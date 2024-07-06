import Foundation
import ArgumentParser
import Welp

struct WelpCommand: ParsableCommand {
	static let configuration = CommandConfiguration(commandName: "welp")

	@Flag(
		name: .shortAndLong,
		help: "Print the version and exit."
	)
	var version: Bool = false

	func run() throws {
		if version {
			throw CleanExit.message("0.0.1")
		}
	}
}

WelpCommand.main()
