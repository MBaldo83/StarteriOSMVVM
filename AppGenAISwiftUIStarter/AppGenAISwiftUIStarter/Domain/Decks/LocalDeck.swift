import Foundation

struct LocalDeck: Identifiable, Hashable {
    let id: UUID
    let name: String
    let deckDescription: String
    let questions: [Question]
}
