# Welp
Tooling for macOS help books that shouldn't need to exist.

The help book format for macOS is effectively abandoned. I'd like to explore building something that is easier to work with.

## Usage

Provides an interface to the `NSUserInterfaceItemSearching` API.

```swift
Help.register(Help.Handlers(items: searchItems, allTopics: allTopics))

func searchItems(_ query: String, limit: Int) async -> [Help.Item] {
    // perform your query and produce at most `limit` items
    
    return items
}

@MainActor
func allTopics(_ query: String) {
    // Handle the "Show All Help Topics" items for a given query string 
}
```

## Contributing and Collaboration

I'd love to hear from you! Get in touch via an issue or pull request.

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
