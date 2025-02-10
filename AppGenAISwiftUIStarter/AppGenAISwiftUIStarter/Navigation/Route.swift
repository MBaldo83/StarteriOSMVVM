import Foundation

extension Router {
    enum Route: Hashable {
        case deckDetails(deck: LocalDeck)
        case cafeProductDetail(product: CafeProduct)
    }
}
