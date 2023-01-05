Developers frequently debate about how to best simplify code, make it more readable, or otherwise reduce the cognitive and mental load of the code we write. Cognitive load refers to the amount of strain we put on our short-term memory, while mental load describes the amount of strain we put on our brains as whole. Any form of cognition (thinking, reading, processing) requires energy, and just like the rest of your body, the brain’s energy levels get depleted.



When that happens, our ability to think declines&mdash;we become slower at comprehending and the number of mistakes we make increases. This means that there is a limit on how much higher-level thinking our brains can do in a given day. **Reducing unnecessary cognitive and mental load allows us to focus on the most important things and get more done.**

That said, cognitive load is not a term that everyone loves. It’s often used as an argument for or against something but presented as a definitive argument: “we should do it this way because it reduces cognitive load”. Without actually understanding how our brains interpret code and navigate complexity this argument lacks validity and is often used dismissively. More often than not, the concept we’re really talking about is mental load. My hope is that we can start to understand what does contribute to cognitive and mental load in software engineering and intentionally apply cognitive science to our engineering patterns.

# Reducing cognitive and mental load

While scaling problems in software can often be solved by throwing more CPU at the problem, we can’t throw more CPU at our brains<sup>1</sup>. If we want to get more done, there is no scaling out when it comes to cognition&mdash;there is only reducing the cognitive requirements of a given task. In other words, reducing mental load is critical to producing better outcomes.

In the context of writing code, the benefit of reducing mental load is often not felt immediately by the developer, but instead by code reviewers and future maintainers. When we reduce the mental load of our code we gain:

- Quicker code reviews (it takes less time for someone to check that the logic of the code is correct)
- Safer code reviews (it becomes easier to see where security issues might arise)
- Fewer bugs (it becomes easier for code reviewers to catch bugs before code is deployed)
- More maintainable code (future developers will be able to more easily comprehend how existing code works and identify where code changes need to happen)
- Less tech debt (when code is more maintainable, it’s more likely to be maintained&mdash;there are fewer “scary corners” of a code base no one wants to touch)
- Increase in time that developers have to do other things (when it’s easier to understand and maintain code, more brain power can be spent on other tasks)

So how can we use cognitive science to write better code? Similar to the development of written language, we can evolve our programming languages and patterns to work in ways that work with our brains. Stanislas Dehaene states in *Reading in the Brain: The New Science of How We Read*:

> “Our cortex did not specifically evolve for writing—there was neither the time nor sufficient evolutionary pressure for this to occur. On the contrary, writing evolved to fit the cortex.”<sup>2</sup>

In the same way that written language evolved to work with our brains, code inevitably will too. Although we are just beginning to scratch the surface in understanding how our brains work, we can use what we do know to help speed up this evolution.

# Coding patterns supported by brain science

There are a few coding patterns that are supported by what we know about how our brains work. Some of these may seem basic, but my hope is that with the backing of cognitive research, we’ll enhance understanding of just how important some coding patterns can be. A few of these patterns are:

- [Make code ignorable](/posts/make-code-ignorable)
- [Use full variable names](/posts/always-use-full-variable-names)
- [Establish & adhere to conventions](/posts/establish-and-adhere-to-conventions)
- [Avoid conventions that require (meaningless) deviation](/posts/avoid-conventions-that-require-meaningless-deviation)

In order to save you infinite scrolling, each pattern will be expanded on in its own post and is linked to above. It’s important to note that what we know about the brain evolves constantly. As we learn more, it’s possible that these patterns no longer make sense, and we should aim to be flexible in incorporating new research into how we code.

---

<sup>1</sup> While we can enlarge parts of brain through increased use, this increase is highly constrained by other brain regions and by our skulls.

<sup>2</sup> *Reading in the Brain: The New Science of How We Read* by Stanislas Dehaene, page 150
