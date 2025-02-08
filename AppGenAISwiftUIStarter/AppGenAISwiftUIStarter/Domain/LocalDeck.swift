import Foundation

struct LocalDeck: Identifiable, Hashable {
    let id: UUID
    let name: String
    let questions: [Question]
}
