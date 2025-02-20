import Foundation

extension Router {
    enum Route: Hashable {
        case deckGenerator
        case deckDetails(deck: Deck)
        case cafeProductDetail(product: CafeProduct)
        case cafeProductsList
        case savedDecks
    }
}
