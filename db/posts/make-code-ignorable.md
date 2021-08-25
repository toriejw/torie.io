“Make code ignorable” is one of the first pieces of advice I ever received in a code review (thank you, [Jeff](https://twitter.com/j3)). It’s also advice backed up by brain science, and a pattern that greatly increases the maintainability of our code.

# What does it mean to “make code ignorable”?

Making code ignorable means preventing any unnecessary parsing of code. If I’m only interested in modifying what happens when a database call fails, I shouldn’t have to parse through all of the logic around a successful database call to find the code that handles failures. Ignorable code removes ambiguity around where to find what you’re looking for by encapsulating logic. Making code ignorable is about making it easy to find the code we care about, without distracting a reader with anything unrelated.

An example of non-ignorable code (in Ruby):

```
user.save
if user.persisted? && user.opted_in_to_email?
  user.send_registration_success_email!
  …
elsif user.persisted? && !user.opted_in_to_email?
  …
elsif !user.persisted? && params[:opted_in_to_email]
  send_error_email(email_address)
  …
else
   … handle error
end
```

Making this code ignorable could look like:

```
if user.save
  handle_successful_registration(user)
else
  handle_unsuccessful_registration(user)
end
```

This allows the code reader to very easily ignore all of the logic encapsulated in `handle_unsuccessful_registration` and skip straight to `handle_unsuccessful_registration`.

# How does brain science support this pattern?

Our brains are designed to increase efficiency by ignoring what they don’t need<sup>1</sup>. In our example above, the reader is forced to parse through each logic branch to determine which one they care about. This work is unnecessary, as we can provide a more efficient way for the reader to get to the code they care about.

In the infamous gorilla study where participants are tasked with counting passes of a basketball while a gorilla walks by, many of the participants don’t notice the gorilla. We’re generally shocked by this and find it hard to believe that someone could just miss a gorilla walking right through the group of people passing a basketball. But recognizing a gorilla isn’t what the participants of this study were tasked with doing&mdash;their brains ignore it because it doesn’t help them achieve their goal of counting passes<sup>2</sup>. The brain is increasing its efficiency in achieving the task at hand (counting passes) by ignoring irrelevant inputs (a gorilla walking by). This is efficient, and we can similarly increase our efficiency in reading code by making it obvious to readers exactly what they are free to ignore.

Beyond increasing the efficiency of pinpointing relevant code, making code ignorable helps free up short-term memory (also called working memory). If you’ve ever opened a file while searching for some piece of functionality and thought “what am I looking for again?”, that’s likely due to information having been pushed out of your short-term memory.

The average short-term memory can only store four items at any one time<sup>3</sup>, so making sure we only force relevant information into our short-term memory frees up mental space for the most important things. In our example above, the reader is likely holding the different branches of logic in their working memory unnecessarily. By making that code ignorable, they can skip unnecessary processing steps, free up their short-term memory for more important things, and go straight to the code they care about.

---

<sup>1</sup> *Incognito: The Secret Lives of the Brain* by David Eagleman, page 28

<sup>2</sup> *How Attention Works: Finding Your way in a World Full of Distraction* by Stefan Van Der Stigchel, page 3-7

<sup>3</sup> *Idiot Brain: What Your Head Is Really Up To* by Dean Burnett, page 36-38
