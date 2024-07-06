<div align="center">

[![Build Status][build status badge]][build status]
[![Matrix][matrix badge]][matrix]

</div>

# Welp
Tooling for macOS help books.

The help book format for macOS is effectively abandoned. Yet, it still remains one of the best ways to deliver in-app help content. Nearly all of the built-in macOS apps use it. But, it can be a real struggle. Welp is all about building tooling to make the process easier.

The project has five components:

- `Welp` library for working with help books programmatically
- `welp` cli tool for help book automation
- `Help Book.xctemplate` an Xcode template that sets up a help book bundle target
- `WelpBook` a (very) experimental library that replaces the help book format entirely

I have some [JavaScript](Help%20Book.xctemplate/helpbook.js) here that is needed to drive the in-browser navigation system. It does not work quite yet, and I also do not know the best way to distribute it. If you have ideas here, I'd love some help!

## Installation

Welp is available as both a command-line tool and a library.

Tool:

```
brew tap ChimeHQ/Welp https://github.com/ChimeHQ/Welp.git
brew install welp
```

Package:

```swift
dependencies: [
    .package(url: "https://github.com/ChimeHQ/Welp", branch: "main")
],
targets: [
    .target(name: "MyTarget", dependencies: ["Welp"]),
	.target(name: "MyOtherTarget", dependencies: ["WelpBook"]),
]
```

## Tool Usage

*forthcoming - tool needs to be built first*

## Template Usage

First, the template must be installed. The on-disk path determines where Xcode displays it in its UI. These instructions place it in `macOS` > `Other`, under the `Project Templates` main group.

```bash
cd Welp
mkdir -p ~/Library/Developer/Xcode/Templates/Project\ Templates/macOS/Other
cp -r Help\ Book.xctemplate ~/Library/Developer/Xcode/Templates/Project\ Templates/macOS/Other/
```

Unfortunately, this template is missing a few features. This means there are some extra steps required to make it actually work.

#### Copy

Add the help book bundle into your main app via the "Copy Bundle Resources" phase.

I *thought* that `AssociatedTargetNeedsProductBuildPhaseInjection` would make this automatic, but I cannot figure out how to control how Xcode adds it into the associated target's build phases.

#### Info.plist Addition

I *think* it is necessary to add an entry into your main app's Info.plist. `CFBundleHelpBookFolder` should be set to `YourHelpBook.help`.

## WelpBook Usage

Please do keep in mind this is experimental. This provides an interface to the `NSUserInterfaceItemSearching` API.

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

## References

- [Authoring Apple Help](https://developer.apple.com/library/archive/documentation/Carbon/Conceptual/ProvidingUserAssitAppleHelp/authoring_help/authoring_help_book.html)
- [Authoring macOS Help Books in 2020 (and beyond)](https://marioaguzman.wordpress.com/2020/09/12/auth/)
- [Why won't that help book open](https://eclecticlight.co/2021/11/16/why-wont-that-help-book-open/)
- [Phel: Publish help books for your Mac apps](https://www.checksimsoftware.com/phel/)

## Contributing and Collaboration

I'd love to hear from you! Get in touch via an issue or pull request.

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

[build status]: https://github.com/ChimeHQ/Welp/actions
[build status badge]: https://github.com/ChimeHQ/Welp/workflows/CI/badge.svg
[matrix]: https://matrix.to/#/%23chimehq%3Amatrix.org
[matrix badge]: https://img.shields.io/matrix/chimehq%3Amatrix.org?label=Matrix
