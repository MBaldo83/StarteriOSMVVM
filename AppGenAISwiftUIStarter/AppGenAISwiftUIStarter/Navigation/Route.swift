import Foundation

extension Router {
    enum Route: Hashable {
        case deckGenerator
        case deckDetails(deck: LocalDeck)
        case cafeProductDetail(product: CafeProduct)
        case cafeProductsList
        case savedDecks
    }
}
