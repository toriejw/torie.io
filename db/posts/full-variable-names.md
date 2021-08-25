It’s hard to find code that doesn’t use shortened variable names. Developers often use `e` instead of `error`, `tx` instead of `transaction`, and `ctl` instead of `control`. When we first began programming computers, shorter variables names were used in order to save computer memory. Memory was relatively limited in the first programmable computers, and so shorter variable names allowed for more complex programs. Computer memory capacity has increased exponentially since we began programming, and shortening variable names is no longer the approach we reach for when we do have memory problems, so it’s time we ditched the desire to keep variable names excessively short.



Shorter variable names make code harder to comprehend. Researchers reported that **[bugs in code were identified 19% faster](https://doi.org/10.1007/s10664-018-9621-x) when words were used as variable names versus single letters or abbreviations**. Why might this be? One explanation has to do with how our brains process written language.

# How do full variable names improve code comprehension?

Although not yet fully understood, there is evidence that there exists a link between how our brains process language and how they process code<sup>1</sup>. In order to start understanding how our brains process code, we can look at how our brains process language as a point of reference. One relevant aspect of written language processing is that **our brains do not respond in the same way to character combinations like “ctl” or “tx” as they do to “control” or “transaction”**.

Any word we read gets processed in a region called the brain’s “letter box”, a region responsible for recognizing written words. When a series of letters do not match the spelling rules of a language, there is less activation in the “letter box” region of our brain than when processing a plausible word<sup>2</sup>. In English, a word containing no vowels would result in less activation than a word containing vowels.

This means that the “letter box” region of our brain does not recognize abbreviations like “ctl” or “tx” as well as it does their unabbreviated versions (“control” and “transaction”). The more we encounter these abbreviations, the easier they become to read, because our brains learn to process these letter combinations as words.

If you’ve been programming for 10 years, you may comprehend “ctl” just as fast you comprehend “control”. Newer programmers however, or developers new to a business domain with business-specific abbreviations, won’t have these associations yet programmed in their “letter box”. Once you’ve learned them, it may seem unnecessary to go back to the full variable names, but there is no reason to force new hires or junior developers to create these new associations and slow down their onboarding and their ability to comprehend new code.

Working memory also plays a critical role in comprehending code, and working memory appears to prefer verbal information that is pronounceable. “transaction” is far more pronounceable than “tx”, so using full variable names could also be making better use of our working memory<sup>3</sup>. Using full variable names could allow us to store more information in our working memory and help us keep track of more information at once.

By using full variable names, **we can speed up onboarding and ramp up time, make better use of our working memory, and find bugs faster**. The benefits of using full variable names far outweigh any slight increase in memory usage. And if memory usage does become a problem for your program, there are almost certainly far more effective approaches you can take to reducing it.

# When is it okay to use abbreviations?

There are certain scenarios where it does make sense to use abbreviations. If the abbreviation is the standard way people refer to something, and the unabbreviated version doesn’t provide useful information about the term, it’s better to use the abbreviation. An example would be “gif”, which is an abbreviation for “graphics interchange format”. If you’re writing code to allow someone to upload a gif, you could write:

```
def upload_graphics_interchange_format
   …
end
```

But that will almost certainly be more confusing than using the abbreviation and writing `def upload_gif`.

Although we may know what the words “graphics”, “interchange”, and “format” mean on their own, putting them together does not tell us that we’re talking about a short video type of media. Referring to a gif in its unabbreviated form would not make it any clearer what we’re referring to, and almost certainly confuse the person reading the code more than simply using "gif".

That said, most unabbreviated versions of words or terms do provide useful information, and the majority of the time we should be avoiding abbreviations in favor using full variable names.

---

<sup>1</sup> Some examples include evidence that [brain areas associated with language processing are activated during code reviews](https://ieeexplore.ieee.org/document/7774510), [those with languages skills are better at learning how to code](https://www.nature.com/articles/s41598-020-60661-8), and evidence showing [less brain activation when reading code with semantic cues](https://dl.acm.org/doi/10.1145/3106237.3106268), suggesting semantic cues decrease the effort required in code comprehension.

<sup>2</sup> *Reading in the Brain: The New Science of How We Read* by Stanislas Dehaene, page 95-100

<sup>3</sup> *Idiot Brain: What Your Head Is Really Up To* by Dean Burnett, page 121
