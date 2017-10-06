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

posts = [
  { title: "The Ruby Object Model", body: object_model_body, created_at: Date.parse("20150912") }
]

posts.each do |post|
  fresh_post = BlogPost.find_or_initialize_by(title: post[:title])
  fresh_post.body = post[:body]
  fresh_post.created_at = post[:created_at] if post[:created_at]
  fresh_post.save!
end
