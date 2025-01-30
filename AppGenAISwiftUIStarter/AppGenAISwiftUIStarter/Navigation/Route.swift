import Foundation

extension Router {
    enum Route: Hashable {
        case deckDetails(deck: LocalDeck)
    }
}
