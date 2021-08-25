Establishing and adhering to conventions may not seem like a revelatory suggestion for your codebase, but the frequency with which we fail to adhere to them suggests we may not understand just how important conventions are. If we don’t adhere to them, conventions become meaningless. There’s often social pressure to not call out “nits” in code reviews, but next time you’re tempted to avoid blocking a pull request merge because of a convention deviance, I’d suggest you re-consider.

# What is a “convention”?

A convention in software is an agreed upon pattern, guideline, or any expectation on how changes should be made to a codebase. Some examples would be:

- Use double quotes (“”) instead of single quotes (‘’)
- Squash all git commits in a pull request before merging into the main branch
- An agreed upon file structure (models go in the `models/` folder, controllers go in the `controllers/` folder)

# Why establish conventions?

Conventions serve two main purposes: first, to make a decision on how to do something once and never have to decide again; and second, to increase the predictability of your codebase. Our brains are wired for prediction, and there’s evidence that prediction processing happens in almost all regions in the brain <sup>1</sup>. This allows us to anticipate and take mental shortcuts which are critical for navigating a complex world. They’re similarly critical for navigating a complex codebase.

By establishing and adhering to conventions, we are better able to make use of our brains’ predictive wiring—when we all agree to put controller files in the `controllers/` folder, we can accurately predict where to look for a controller file we’re interested in. This saves us time and mental energy because we don’t have to make any guesses about where to find what we’re looking for. We can also add a new controller file without internal debate on where that file should go.

# What happens when we don’t adhere to conventions?

Say the programming language we’re working with allows developers to define a function in two different ways. A team has decided that they will always use the same way to define a function. But at some point, someone forgot and defined a function in the alternative way. The code reviewer didn’t point it out, the code was merged, and now the code base no longer adheres to the established convention.

The next developer to look at that code will not be expecting a function to be defined like that. Our brains will pick up on that deviation, and automatically draw our attention to it. **Our brains will highlight the deviation as “anomalous” and worthy of higher-level processing, thereby forcing you to pay attention**<sup>2</sup>. This might not be a bad thing if the second developer's goal is specifically to clean up deviations from a convention. In all other cases, however, your attention being drawn to that is a distraction. Maybe it’s not even the code you were interested in updating, and even if it is, you’re now forced to think about the deviation rather than the logic of the function.

Not only does this unnecessarily increase your mental load, but it physically slows your brain down. The information on how the function was defined has been forced to be processed by the part of your brain (executive functioning) that operates more slowly than the regions that otherwise process that information<sup>3</sup>. When code is written in a predictable way, we’re able to make use of existing brain circuitry we’ve already developed to process it. This is one way our brains maximize energy efficiency, and we should aim to make use of it as much as possible<sup>4</sup>.

On the flip side of deviations unnecessarily distracting us, when searching for something specific, your brain automatically filters out anything deemed irrelevant<sup>5</sup>. Say we have established a convention to always use single quotes when defining a string, unless the string contains dynamic content, then we use double quotes with string interpolation:

```
log_error(‘failed to process!’)
log_error(“failed to process request for user ID #{id}, user name #{name}: #{error.message}”)
```

Let’s say we need to update the error message that contains the string interpolation, because we shouldn’t be logging user’s names (for security reasons). Assuming I don’t already have a back trace that tells me what line this code is called on, when I’m scanning a file to find it, I will automatically be looking for a string with double quotes because our convention has led me to expect that. But what if someone hadn’t adhered to that convention, and instead wrote:

```
log_error(‘failed to process request for user ID’ + id + ‘, user name’ + name ‘: ‘ + error.message)
```

As I’m skimming the file, my brain is far more likely to filter out that line with single quotes, because its efficient for my brain to do so. Because this code deviates from expectations, it has become harder to find it when that is the code we’re specifically looking for, and more costly to find other code when we skim the surrounding code. We are far more likely to fail to see something when it doesn’t match our expectations. In other words, it will be much more difficult to find a line of code or file we’re searching for when what we’re looking for does not adhere to our established conventions.

# How do we decide what our conventions should be?

Generally speaking, the establishment of conventions is far more important than what convention is actually chosen. That said, brain science can also help us choose more productive conventions. [“Avoid Conventions That Require Meaningless Deviation”](/avoid-conventions-that-require-meaningless-deviation) explores a starting principle for choosing good conventions.

---

<sup>1</sup> *Annoying: The Science of What Bugs Us* by Flora Lichtman and Joe Palca

<sup>2</sup> *How Attention Works: Finding Your way in a World Full of Distraction* by Stefan Van Der Stigchel, page 48

<sup>3</sup> *How Attention Works: Finding Your way in a World Full of Distraction* by Stefan Van Der Stigchel, page 71

<sup>4</sup> *Incognito: The Secret Lives of the Brain* by David Eagleman, page 72-73

<sup>5</sup> *How Attention Works: Finding Your way in a World Full of Distraction* by Stefan Van Der Stigchel, page 13
