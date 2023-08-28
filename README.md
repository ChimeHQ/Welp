[![License][license badge]][license]

# Welp
A macOS help book alternative that shouldn't need to exist.

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

## Suggestions or Feedback

We'd love to hear from you! Get in touch via an issue or a pull request.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

[license]: https://opensource.org/licenses/BSD-3-Clause
[license badge]: https://img.shields.io/github/license/ChimeHQ/Welp
