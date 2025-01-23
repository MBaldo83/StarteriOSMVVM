import Foundation

struct LocalDeck: Identifiable {
    let id: UUID
    let name: String
    let questions: [Question]
}
