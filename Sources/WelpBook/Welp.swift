import AppKit

public struct Help {
	/// An item returned to the help system.
	///
	/// This value is unchecked because even though it passes through concurrency domains, we know that `action` will only ever actually be accessed from the MainActor.
	public struct Item: Sendable {
		public typealias Action = @MainActor () -> Void

		public let localizedTitles: [String]
		public let action: Action

		public init(localizedTitles: [String], action: @escaping Action) {
			self.localizedTitles = localizedTitles
			self.action = action
		}

		public init(localizedTitle: String, action: @escaping Action) {
			self.init(localizedTitles: [localizedTitle], action: action)
		}
	}

	public typealias ItemHandler = (String, Int) async -> [Item]
	public typealias AllTopicsHandler = @MainActor (String) -> Void

	public struct Handlers {
		public let items: ItemHandler
		public let allTopics: AllTopicsHandler

		public init(items: @escaping ItemHandler, allTopics: @escaping AllTopicsHandler) {
			self.items = items
			self.allTopics = allTopics
		}
	}

	/// Register with the help search system.
	@MainActor
	public static func register(_ handlers: Handlers) {
		let searcher = InterfaceSearcher.shared

		searcher.deregister()

		searcher.handlers = handlers

		searcher.register()
	}

	/// Deregister from the help search system.
	///
	/// This is safe to call more than once.
	@MainActor
	public static func deregister() {
		InterfaceSearcher.shared.deregister()
	}
}

@MainActor
final class InterfaceSearcher: NSObject {
	static var shared = InterfaceSearcher()

	var handlers: Help.Handlers
	private var currentSearch: Task<Void, Never>?

	override init() {
		self.handlers = .init(items: { _, _ in [] }, allTopics: { _ in })

		super.init()
	}

	func register() {
		NSApp.registerUserInterfaceItemSearchHandler(self)
	}

	func deregister() {
		// oh you want to put this into deinit right? You cannot, because NSApp is MainActor...
		NSApp.unregisterUserInterfaceItemSearchHandler(self)
	}
}

#if compiler(>=6.0)
extension InterfaceSearcher: @preconcurrency NSUserInterfaceItemSearching {
}
#else
extension InterfaceSearcher: NSUserInterfaceItemSearching {
}
#endif

extension InterfaceSearcher {
	nonisolated func searchForItems(withSearch searchString: String, resultLimit: Int, matchedItemHandler handleMatchedItems: @escaping ([Any]) -> Void) {
		// by my reading of the documentation, `matchedItemHandler` is actually sendable but is not correctly annotated
		let sendableMatchHandler = unsafeBitCast(handleMatchedItems, to: (@Sendable ([Any]) -> Void).self)

		let task = Task { @MainActor in
			self.currentSearch?.cancel() // cancel any active search

			let handler = self.handlers.items

			let items = await handler(searchString, resultLimit)

			sendableMatchHandler(items)
		}

		// this is very awkward
		Task { @MainActor in
			self.currentSearch = task
		}
	}

	nonisolated func localizedTitles(forItem item: Any) -> [String] {
		guard let item = item as? Help.Item else {
			print("unexpected value returned in NSUserInterfaceItemSearching \(item)")
			return []
		}

		return item.localizedTitles
	}

	func performAction(forItem item: Any) {
		guard let item = item as? Help.Item else {
			print("unexpected value returned in NSUserInterfaceItemSearching \(item)")
			return
		}

		item.action()
	}

	func showAllHelpTopics(forSearch searchString: String) {
		self.handlers.allTopics(searchString)
	}
}
