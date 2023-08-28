import Cocoa
import SwiftUI

import Welp

struct ContentView: View {
	var body: some View {
		Text("jello")
			.toolbar {
				ToolbarItem(placement: .navigation) {
					Button(action: toggleSidebar, label: {
						Image(systemName: "sidebar.leading")
					})
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}

	private func toggleSidebar() {
	}
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	lazy var window: NSWindow = {
		let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
							  styleMask: [.titled, .closable, .unifiedTitleAndToolbar, .resizable],
							  backing: .buffered,
							  defer: true)

		return window
	}()

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		Help.register(.init(items: self.helpSearch, allTopics: self.allTopics))

		window.title = "Something Help"
		window.contentView = NSHostingView(rootView: ContentView())
		window.toolbarStyle = .unifiedCompact
		window.setContentSize(NSSize(width: 400, height: 300))
		window.center()

		window.makeKeyAndOrderFront(self)


//		window.styleMask.update(with: .unifiedTitleAndToolbar)
	}

	func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
		return true
	}

	func helpSearch(_ query: String, limit: Int) -> [Help.Item] {
		return [
			Help.Item(localizedTitles: ["a"], action: { print("a") }),
			Help.Item(localizedTitles: ["a", "b"], action: { print("a") }),
			Help.Item(localizedTitles: ["a", "b", "c"], action: { print("c") }),
		]
	}

	func allTopics(_ query: String) {
		print("all topics for:", query)
	}
}

//extension AppDelegate: NSUserInterfaceItemSearching {
//	enum HelpItem {
//		case value(String)
//	}
//
//	func searchForItems(withSearch searchString: String, resultLimit: Int, matchedItemHandler handleMatchedItems: @escaping ([Any]) -> Void) {
//		let items = [
//			HelpItem.value("a"),
//			HelpItem.value("B"),
//			HelpItem.value("CCC"),
//		]
//
//		handleMatchedItems(items)
//	}
//
//	func localizedTitles(forItem item: Any) -> [String] {
//		switch item as? HelpItem {
//		case .value(let v):
//			return [v, "thing", "other"]
//		default:
//			return ["nothing"]
//		}
//	}
//
//	func performAction(forItem item: Any) {
//		print("perform: \(item)")
//	}
//	
//	func showAllHelpTopics(forSearch searchString: String) {
//		print("show help for ", searchString)
//	}
//}

@MainActor
func doThing() {
	Help.register(Help.Handlers(items: searchItems, allTopics: allTopics))
}

func searchItems(_ query: String, limit: Int) async -> [Help.Item] {
	// perform your query and produce at most `limit` items

	return items
}

func allTopics(_ query: String) {
	// Handle the "Show All Help Topics" items for a given query string
}
