SQL injection is one of the most common security vulnerabilities in software. In 2017, The Open Web Application Security Project (OWASP) [listed injection as the number one security risk](https://owasp.org/www-project-top-ten/) to web applications. An updated list is due out this year, and injection is expected to remain at the top of that list.

# What is SQL injection?

SQL injection (SQLI) is the use of SQL code to access or modify data that was not intended to be accessed or modified. This happens when user input is naively trusted and passed directly into a database query. A user can enter malicious SQL into website forms or modify URLs and HTTP request parameters to contain SQL code. When this input is trusted, the malicious user is able to bypass database authorization and access other users' data, modify other users' data, and even delete entire database tables using SQLI.

# How does SQL injection work?

In order to understand how to prevent SQLI, it's useful to understand what it looks like and how it's performed.

Say we have some code that looks up a user by their username:

```
User.where("username = '#{params[:username]}'")
```

This code expects a parameter `:username` to be provided, and it passes it directly into our database query. In our happy path, we might end up with a query like `User.where("username = 'DogLover34'")`, and properly return the user with that username.

However, if someone wanted to attempt a SQLI attack, they may provide a "username" like `"username' OR 1='1"`. If we naively trust the user's input, we'll end up with the following query:

```
User.where("username = 'username' OR 1='1'")
```
ActiveRecord translates this to the following SQL:
```
SELECT "users".* FROM "users" WHERE (username = 'name' OR 1='1')
```
This tells our database to check each row in our `users` table to see if it matches our query. But because the last part of that statement (`1='1'`) will always resolve to true, this query will return every record in our `users` table. Our malicious user will have access to every single person's data, regardless of their authorization to do so.

Similar injections can be performed for deletes, updates, and even database calculations like `SUM()` and `AVG()`. You can find more examples of SQLI in Rails [here](https://rails-sqli.org/).

# How can we prevent SQL injection?

## Input sanitization

The "brute force" method for preventing SQLI is limiting what user input your code accepts. In our example above, if we decide to only accept letters, it would be impossible for a user to enter a username like `"username' OR 1='1"`. If we modified their input ourselves to conform to our validations, we'd end up with `usernameOR` and safely query our `users` table:

```
User.where("username = 'usernameOR'")
```

It's important to note here that this method requires backend validations in order to be effective. Malicious users can make use of tools that intercept requests sent from a browser to your backend and allow them to modify parameters before sending the request on to the server. Consequently, frontend validations are not sufficient to prevent SQLI.

In many cases we really do want to allow input beyond just letters or numbers,
and this method of preventing SQLI is quite limiting. It is also possible to find loopholes around sanitization if that's the only layer of protection against SQLI. Fortunately, we have more advanced methods for preventing SQLI that still allow our users to include whitespace and special characters.

## Rails helpers

Rails provides us with [query methods](https://guides.rubyonrails.org/active_record_querying.html#retrieving-objects-from-the-database) that help prevent SQLI, as well as a [handy explainer on SQLI](https://guides.rubyonrails.org/security.html#sql-injection) in their docs.

These methods allows us to query a database without writing _any_ SQL. ActiveRecord handles sanitizing and parameterizing (more on that below) for us, in order to allow us to safely perform queries. In these methods, ActiveRecord sanitizes any string input by escaping `'`, `"`, the NULL character, and line breaks.

Some examples of these query methods are:
```
User.find(1)
User.find_by(username: "username")
User.find_by_username("username")
User.where(username: "username")
```
In our example from above, we can instead use an attribute-based finder to make our query safe from SQLI and replace our `User` search with:
```
User.where(username: params[:username])
```
These ActiveRecord methods are great for performing standard queries, but occasionally we need to perform more complicated queries that ActiveRecord isn't designed to handle. These scenarios may require us to write some raw SQL, in which case we need another strategy for preventing SQLI. The best way to do this is by parameterizing our queries.

## Parameterized queries

Parameterized queries are a very powerful tool for preventing SQLI. A **parameterized query** is a SQL query that is parsed and compiled before being executed. Importantly, parameter values are only applied to the query **on execution**.

Parsing and compiling the query in advance is referred to as "preparing" the query, and the output is called a **prepared statement**. Prepared statements are stored without being executed. They are cached for the duration of a database session and are queryable with: `ActiveRecord::Base.connection.execute("select * from pg_prepared_statements")`.

The ActiveRecord version of a parameterized query can be written in the following way:

```
User.where("username = ?", params[:username])
```

The parameter value we're supplying here (`params[:username]`) is called a **bind parameter** or **dynamic parameter**, because we're passing it to the query on execution rather than on query preparation.

This prevents SQLI because the query is prepared with the expectation that it is only checking the value of `username`. If a malicious user tries to inject an `OR` into this query, the input would be considered invalid because the prepared statement was not expecting to handle an `OR` clause.

When we need to query using raw SQL, we can build parameterized queries like this:

```
User.find_by_sql("SELECT * FROM users WHERE username = $1", [[nil, "username"]], preparable: true)
```

In this query, `$1` represents where our bind parameter `"username"` will be inserted on execution. If we had more parameters, they would be represented by `$2`, `$3`, and so on. A query with multiple parameters would look like:

```
User.find_by_sql("SELECT * FROM users WHERE username = $1 AND password = $2", [[nil, "username"], [nil, "secret-password"]], preparable: true)
```

The parameter `preparable: true` is what tells this query to create a prepared statement. Our bind parameters in this query are: `[[nil, "username"], [nil, "secret-password"]]`. Each bind parameter is represented by an array containing a column/value pair. The column reference is unnecessary here, so we use `nil`.

 Prepared statements are also a great tool for query optimization, since they are cached and can be used whenever a common query is run. As a result, we only have to perform the work of parsing and compiling a given query once per database session.

 ActiveRecord does a huge amount of work for us in preventing SQLI, but it's important to always be thinking about how your code might be vulnerable. Whenever possible, we should make use of the tools ActiveRecords has provided us, and only when those prove insufficient should we write our own SQL queries.
