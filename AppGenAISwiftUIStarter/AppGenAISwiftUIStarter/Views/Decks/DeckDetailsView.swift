import SwiftUI

struct DeckDetailsView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        DeckDetailsContentView(
            deck: viewModel.deck,
            viewActionOne: viewModel.viewActionOne
        )
    }
}

// This can be used in Previews
struct DeckDetailsContentView: View {
    
    let deck: Deck
    let viewActionOne: () -> Void
    
    var body: some View {
        VStack {
            Button(
                "View Action 1",
                action: viewActionOne
            )
            Text("Name: \(deck.name ?? "")")
//            Text("Question Count: \(deck.questions.count)")
        }
    }
}

extension DeckDetailsView {
    
    @Observable
    class ViewModel {
        
        var deck: Deck
        
        init(deck: Deck) {
            self.deck = deck
        }
        
        func viewActionOne() {
//            deck = .init(
//                id: deck.id,
//                name: deck.name,
//                questions: deck.questions + [
////                    Question(id: UUID(), question: "New Question", answer: "The Answer")
//                ]
//            )
        }
    }
}
