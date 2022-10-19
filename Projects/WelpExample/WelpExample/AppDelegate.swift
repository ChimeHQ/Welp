import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	@IBOutlet var window: NSWindow!

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		NSApp.registerUserInterfaceItemSearchHandler(self)
	}

	func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
		return true
	}
}

extension AppDelegate: NSUserInterfaceItemSearching {
	enum HelpItem {
		case value(String)
	}

	func searchForItems(withSearch searchString: String, resultLimit: Int, matchedItemHandler handleMatchedItems: @escaping ([Any]) -> Void) {
		let items = [
			HelpItem.value("a"),
			HelpItem.value("B"),
			HelpItem.value("CCC"),
		]

		handleMatchedItems(items)
	}

	func localizedTitles(forItem item: Any) -> [String] {
		switch item as? HelpItem {
		case .value(let v):
			return [v, "thing", "other"]
		default:
			return ["nothing"]
		}
	}

	func performAction(forItem item: Any) {
		print("perform: \(item)")
	}
	
	func showAllHelpTopics(forSearch searchString: String) {
		print("show help for ", searchString)
	}
}
