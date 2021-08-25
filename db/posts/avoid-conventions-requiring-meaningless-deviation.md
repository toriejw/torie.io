We've discussed the importance of establishing and adhering to conventions, whether that be file structures or code style. While establishing a convention at all is generally more important than what that convention actually is, brain science can provide some guidance on what conventions are most helpful.

One trait of a good convention is that it doesn’t require meaningless deviation. The saying “every rule has an exception” applies to conventions as well, and by being thoughtful about what these exceptions are, we can help reduce noise and consequently cognitive and mental load.

# What is “meaningless deviation”?

“Meaningless deviation” refers to any exception to a convention that doesn’t convey useful information. In other words, if a deviation from a convention is required, the deviation should tell us something about the code that is worth knowing.

As an example, let’s say we’ve decided to always use single quotes instead of double quotes. In Ruby, when we want to perform string interpolation, we can only do so when using double quotes. The result in Ruby would be code that generally uses single quotes, but would deviate from that convention when string interpolation is required:

```
def sign_in_prompt
  ‘Please sign in with your e-mail below:’
end

def sign_in_success_message
  “Welcome back #{user.name}!”
end
```

In this case, the deviation from the convention of using single quotes provides useful information, because we can immediately assume that a string with double quotes will contain dynamic content. This is good to know while reading the code, because it signals that we may want to double check the string for security concerns around injection, or should we end up with a bug where our sign in message displays “Welcome back null!” we can more quickly find the line that contains dynamic content, because we know to look for double quotes.

The deviation here provides us a way to filter the information that our brains process. The deviation helps increase our efficiency in finding what we're looking for, but this is only true because that deviation has meaning.

A “meaningless deviation” from our convention of using single quotes is one that would unnecessarily draw our attention. As an example, in order to write a string with an apostrophe using single quotes, we would have to escape it:

```
loading_message = ‘We\’re fetching your results…’
```

Having backslashes in a string makes it harder to read. An alternative would be using double quotes for the scenario where we want to include an apostrophe:

```
loading_message = “We’re fetching your results…”
```

But this deviation doesn’t provide useful information. Unless it’s important in your codebase to pay special attention to apostrophes in strings, this deviation provides us with no information we actually care about. Instead, we’ll expect this string to contain an interpolated value, but it doesn’t. That makes for an unnecessary distraction, because our attention will be drawn to it for a reason that isn’t important to us and doesn’t warrant any extra attention.

In this example, the better thing to do would be establish the convention of always using double quotes. When we do that, we’ll instead expect to find interpolated values by searching for `#{}` (at least, in Ruby). We don’t lose the ability to find dynamic content&mdash;we instead change the expectation we use to find it, without unnecessarily distracting ourselves with apostrophes.

# Does being momentarily distracted really slow me down?

Any time your brain switches tasks, it undergoes a dynamic transition. A transition results in the activation of different brain regions and different patterns of connectivity within the brain. We know that such transitions exist when the brain goes from perception to attention<sup>1</sup>, as it might if you were scanning code in search of dynamic string content and came across double quotes. This would cause your brain to switch into attention mode from scanning mode and trigger an entire brain transition. One such transition is unlikely to exhaust your brain but add them up and you will likely notice the strain.

# How do we identify conventions that don’t require meaningless deviation?

When establishing a convention, spend some time identifying scenarios when a proposed convention would require deviation. Evaluate whether or not those deviations contain meaning and choose the convention whose deviations provide only useful information.

---

<sup>1</sup> [*A Dendritic Substrate for the Cholinergic Control of Neocortical Output Neurons*](https://doi.org/10.1016/j.neuron.2018.11.035) by Stephen R. Williams and Lee N. Fletcher
