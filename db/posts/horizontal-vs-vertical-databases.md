When someone refers to a database as "vertical" or "horizontal" they are referring to the type of data structure a database uses to store data.

# What is a horizontal database?

This type of database is more common, and the type you're probably familiar with. A `User` table for a horizontal database might look like this:

| User ID  | Name  | E-mail  |
| :-------:|:-----:| :-----:|
| 1        | Olive | olive@example.com |
| 2        | Maya  | maya@example.com |

Horizontal databases store data "horizontally". This means that it is **row-oriented**: it places records into tables by rows. For example: your application creates a new user named Sam, and it adds a new row to the `User` table:

| User ID  | Name  | E-mail  |
| :-------:|:-----:| :-----:|
| 1        | Olive | olive@example.com |
| 2        | Maya  | maya@example.com |
| 3        | Sam   | sam@example.com |

When you add a new `User` record, a new row is added to the `User` table. Horizontal databases contain many tables like this, and each table describes only one type of object.

# What is a vertical database?

Vertical databases are **column-oriented**. Rather than placing data by rows, a horizontal database places data by columns.

These databases will often have one "entity table" that consists of only 3 columns:

| Object identifier  | Attribute  | Value  |
| :-------:|:-----:| :-----:|
| Object type and ID | Foreign key to an attribute definition table | Value of the attribute |

The foreign key for `Attribute` points to a "metadata table". This table stores the different types of attributes, what type an attribute is (string, int, etc.), how long it can be, and so on. Metadata tables can take many forms, but here's an example of what one might look like:

| Attribute ID | Attribute name | Data type | Is required? | Max. length |
|:-------:|:-------:|:-------:|:-------:|:-------:|
| 1 | Name | String | true | 100 |
| 2 | E-mail | String | false | 50 |

(Note that this metadata table is row-oriented, not column-oriented. Some types of vertical databases use horizontal data tables for metadata.)

For a `User` object, our entity table would look like this:

| Object identifier  | Attribute  | Value  |
|:-------:|:-------:|:-------:|
| User 1 | Foreign key for 'Name' | Olive |
| User 1 | Foreign key for 'E-mail' | olive@example.com |
| User 2 | Foreign key for 'Name' | Maya |
| User 2 | Foreign key for 'E-mail' | maya@example.com |

In this way, each row in our entity table represents a column, rather than a complete record. In other words, each row represents a single attribute for a given object. This means that vertical databases do not store empty values. There's no need to store an attribute with an empty value, since that's implied by the lack of table row for a given object and attribute.


# So what's the difference?

In a nutshell, **horizontal databases write data row by row, while vertical databases write data column by column**. Here are some of the key differences:

| Horizontal database  | Vertical database  |
| :-------:| :-----:|
| Places data by row | Places data by column |
| Tables contain only one type of object | Tables can contain entries of different types |
| Generally preferred for web apps | Generally preferred for very large datasets |
| Stores nil attribute values | Does not store empty values |

# Choosing between the two

Generally, horizontal databases are preferred for web applications because data in web applications is often retrieved by records. A user signs into a web app, and the app fetches the `User` object.

Vertical databases are great for very large datasets used for different types of analysis. This is because you often want to know things like: "how many users are over the age of 30?". To answer that question, all you need is the `age` column on `User` &mdash; you don't need the entire record for every `User`, you just need a single column. Because vertical databases are column-oriented, performing that query is much faster.
