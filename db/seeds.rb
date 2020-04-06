object_model_body =
%Q{#What is an object model?

An object model describes how objects in a programming language are constructed behind the scenes. This determines how a language interacts with objects.

#What does the Ruby object model look like?

Ruby’s object model is built on hashes. When you create an object in Ruby, Ruby creates a hash to represent that object. The hash is made up of two keys: `class` and `instance_variables`. The value for `class` will be the class of the object.

The value for `instance_variables` will be another hash, made up of a key for each instance variable the object has, and a value to represent what each instance variable has been assigned to for that specific object. In code, an object would look like this:

    {
      class: ClassName,
      instance_variables: { }
    }

**ClassName** serves as a pointer to the object's class. A class stores information used by the object such as which methods are available to that object. Like objects, Ruby represents classes using hashes. A class hash looks like this:

    {
      superclass: ClassName,
      methods: { },
      constants: { },
      class: ClassName,
      instance_variables: { }
    }

Classes have a few more keys in their hash. When you call a method on an object, Ruby looks in that object's class, finds the `methods` key, and checks if the method you called is in the hash associated with the key `methods`.

If you'd like to go further in depth, I recommend [Vidar Hokstad's post](http://hokstad.com/ruby-object-model).
}

memoization_body =
%Q{#What is memoization?

Memoization is a technique used in programming to speed up accessor methods. For example, let’s say you have the following accessor method in the class `Person`:

    class Person
      def birth_name
        @birth_name = birth_name.capitalize
      end
    end

Every time we call the accessor method `birth_name` Ruby will perform the process of capitalizing the variable `birth_name`. But since a person’s birth name never changes, we shouldn’t need to re-format it every time.

If we memoize this method, Ruby will no longer have to perform this process over and over. Instead, Ruby will cache the result, and next time we call the accessor method `birth_name` Ruby will already have the result stored in memory.

#How do I use memoization?

The simplest way to memoize your accessor methods is using this operator: `||=` . If we wanted to memoize the method from above, this is how we would do it:

    class Person
      def birth_name
        @birth_name ||= birth_name.capitalize
      end
    end

#How does it work?

When you use the `||=` operator, what you’re essentially writing is this:

    class Person
      def birth_name
        @birth_name ||= ( @birth_name || birth_name.capitalize )
      end
    end

That’s saying that if `@birth_name` already exists, then return that. Otherwise, perform the operation `birth_name.capitalize`. If a result is already stored in memory, Ruby will simply return it. Otherwise it will create it.

#When should I use memoization?

In reality, we shouldn’t be using memoization for the method in the example above. The process of capitalizing a string isn’t costly enough to justify memoization. It should only be used for processes that are time-consuming, like loading in large amounts of data.

**Memoization shouldn’t be used in place of good, well-optimized code.** It also should be avoided in multi-process applications, since a memoized variable can be stored as different things in different processes.
}

indexing_in_rails_body =
%Q{#What is indexing?

Database queries can be slow and make your application painful to use. One way to speed things up is to use indexing.

Indexing is the process of building a data structure from a table column in order to search through that table more efficiently. The type of data structure that gets built depends on what type of database you’re using. Different databases have different options. In PostgreSQL there are 4 options: binary tree, hash, generalized search tree, or generalized inverted index. If you don’t specify a specific type, PostgreSQL defaults to binary tree.

If a column on a table is indexed, and you search a table based on that column (eg. `Post.where(title: “My Post”)` – this searches the Post table based on the title column), the database query will traverse the data structure set up by indexing to find what it’s looking for.

Using data structures like a binary tree to search increases the speed of that search immensely. Without it, every single row in a table would have to be looked at. With it, we can greatly reduce the number of table entries that need to be looked at. You can learn more about why binary tree’s are faster [here](http://www.stoimen.com/blog/2012/06/22/computer-algorithms-binary-search-tree-data-structure/).

#How do I index a column?

Assuming you have your database set up with at least one table, indexing a column isn’t too complicated.

First, you need to create a rails migration:

    $ rails g migration AddIndexToTable

Then open the migration, and use Rails’s `add_index` method to create the index. The first parameter is the name of the table you want to add the index to. The second parameter is the name of the column you want to index:

    def change
      add_index :posts, :title
    end

Run the migration, and your database queries should be much faster!

#Should I index all of my columns?

No. While indexing speeds up reading from a database, it also slows down writing to a database. This is because every time it has to add something to a table, it now also has to update the data structure that was made for each indexed column. If your application does a lot more reading than writing, then this trade off is usually a good one, but you should only index columns that you actually query on. If you never need to search for a post based on its title, then it doesn’t make sense to index the title column of the Post table.

Generally, join tables and foreign keys should be indexed. Primary ids are indexed automatically in Rails.
}

horizontal_vs_vertical_db_body = File.open("db/posts/horizontal-vs-vertical-databases.md").readlines.join
go_interfaces_body = File.open("db/posts/go-interfaces.md").readlines.join
sqli_body = File.open("db/posts/sqli-in-rails.md").readlines.join

posts = [
  { title: "The Ruby Object Model", body: object_model_body, created_at: Date.parse("20150912") },
  { title: "Basic Memoization in Ruby", body: memoization_body, created_at: Date.parse("20151006") },
  { title: "Performance Optimization and Indexing in Rails", body: indexing_in_rails_body, created_at: Date.parse("20160225") },
  { title: "Horizontal vs. Vertical Databases", body: horizontal_vs_vertical_db_body },
  { title: "Introduction to Interfaces in Golang", body: go_interfaces_body },
  { title: "SQL Injection in Rails", body: sqli_body },
]

posts.each do |post|
  fresh_post = BlogPost.find_or_initialize_by(title: post[:title])
  fresh_post.body = post[:body]
  fresh_post.created_at = post[:created_at] if post[:created_at]
  fresh_post.save!
end
