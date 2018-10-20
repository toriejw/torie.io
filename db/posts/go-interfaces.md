# What is an interface?

[Merriam-Webster](https://www.merriam-webster.com/dictionary/interface) defines an interface as "the place at which independent and often unrelated systems meet and act on or communicate with each other".

In Go, **an interface is a definition of behaviour**. This definition is independent of any type (such as `string`), and is expressed as a list of methods (I use the word method instead of function here, because a method is a function called on a receiver, which is how functions defined in an interface are used).

# Defining interfaces

An interface in Go looks like this:

```go
type Speaker interface {
  Speak(string) string
}
```

This defines an interface called `Speaker`, with a single method `Speak`.

The first line `type Speaker interface` is what tells Go that this is an interface called `Speaker`. Within the brackets `{...}` is where we define the methods that make up the interface. Because Go is a [strictly typed language](https://stackoverflow.com/questions/805168/what-is-a-strictly-typed-language), we need to specify the input and output types, as well as the method name, when defining methods. In our example above, the interface `Speaker` has a method `Speak` which must accept a string as an input, and the output of `Speak` must also be a string.

Here are some more examples of how you can define methods in an interface:

```go
type Speaker interface {
  Speak(string) string
  Count(int64) string
  UpdateName(string)
  UpdateTitle(string) error
  Commit() (result, error)
  Present(string, ...interface{}) (string, error)
}
```

# Using interfaces

How do we make use of the interface `Speaker` we defined?

In order to use our interface, we need a function that uses our interface as an input. Instead of defining the input of that function as a specific type, we can use our interface instead:

```go
func Record(speaker Speaker, content string) {
  spokenContent = speaker.Speak(content)
  fmt.Println(spokenContent)
}
```

This function takes a parameter `speaker` of "type" `Speaker`. That is, it takes any type that implements the interface `Speaker`.

How does a type implement an interface? Here's an example:

```go
type Teacher struct {
  Name string
}

func (t Teacher) Speak(content string) string {
  return fmt.Sprintf("%s says: %s", t.Name, content)
}
```

The type `Teacher` implements the interface `Speaker` by defining a method that matches the definition of the method `Speak` defined in the `Speaker` interface. The receiver of this method `Speak` must be the type implementing the interface `Speaker`. Now we would be able to use an instance of the type `Teacher` as an input into any method that accepts the interface `Speaker`, such as the function `Record` we saw above:

```go
teacher := Teacher{Name: "Ms. Lopez"}

str := Record(teacher, "Hello! I teach computer science!")
fmt.Println(str)

// => "Ms. Lopez says: Hello! I teach computer science!"
```

# Why use an interface?

The primary reason to use interfaces is [polymorphism](https://www.webopedia.com/TERM/P/polymorphism.html), but there are a few other useful applications of interfaces worth discussing: testing and mixed type collections.

## Testing

Stubbing method calls in Go is more difficult than in other languages, like Ruby. By using an interface, you can create mock types for your tests that implement the interfaces that define methods you'd like to mock out. Here's an example of what that might look like:

Let's say you have a function that sends metrics about your app to an external service. You don't want to be making these calls when you're running tests, so you can use an interface and create a mock type that implements it, but doesn't actually make calls to the external service.

In code that might look like this:

In stats_client.go:

```go
package main

type StatsPublisher interface {
  Record(string) error
}

type StatsClient struct {
  clientKey string
}

func (s *StatsClient) Record(event string) error {
  // publish the event
  return nil
}
```

In main.go, you would set a global variable for your stats client:

```go
package main

func main() {
  statsClient := new(StatsClient)
}
```

Which can then be mocked out in your test files:

```go
type testStatsClient struct {}

func (s *testStatsClient) Record(event string) error {
  return nil
}

func TestSomething(t *testing.T) {
  // set the global variable for StatsClient to the test version
  statsClient := new(testStatsClient)

  // test code
}
```

Now when your tests call functions that would normally make calls to an external metrics service, they will instead make use of the `Record` method defined on `testStatsClient` which makes no external calls.

## Mixed type collections

Another useful application of interfaces (especially for those of us coming from dynamically typed languages) is mixed type collections. Sometimes you need a collection of items that happen to be of different types.

A great example of when you might need this is creating JSON from Go code. Since we need to define the type of the keys and values in a map, we would normally have something like:

```go
 example := map[string]int{
   "one": 1,
   "two": 2,
 }
 ```

But when we build a struct that we intend to transform into JSON, we'll likely need the values in our map to be of different data types. We can achieve this by defining the value type of a map as `interface{}`:

```go
example := map[string]interface{}{
  "one": 1,
  "two": "cat",
}
```

This allows us to use any type that implements an empty interface as our values in this map. Since every type implements an empty interface, this means we can use any type we'd like.

# Interface naming conventions

The Go docs have a great [section on this topic](https://golang.org/doc/effective_go.html?#interface-names) for single method interfaces.

For interfaces with multiple methods, using the `-er` suffix doesn't always make sense. It's common to name the interface after the type or object that the interface represents. There are plenty of examples in Golang's source code, such as the [Error interface](https://github.com/golang/go/blob/cda1947fd12ad31060b30a0a601130bfaa26d234/src/runtime/error.go#L10).
