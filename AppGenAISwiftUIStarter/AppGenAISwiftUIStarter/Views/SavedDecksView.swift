import SwiftUI

struct SavedDecksView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        SavedDecksContentView(
            decks: viewModel.decks,
            viewActionOne: viewModel.viewActionOne
        )
    }
}

struct SavedDecksContentView: View {
    let decks: [LocalDeck]
    let viewActionOne: () -> Void

    var body: some View {
        VStack {
            Button(action: viewActionOne) {
                Text("View Action 1")
            }
            ForEach(decks) { deck in
                Text(deck.name)
            }
        }
    }
}

extension SavedDecksView {
    @Observable
    class ViewModel {
        var decks: [LocalDeck]
        
        init(decks: [LocalDeck]) {
            self.decks = decks
        }
        
        func viewActionOne() {
            // Placeholder for view action.
            if let firstDeck = decks.first {
                decks[0] = LocalDeck(id: firstDeck.id, name: firstDeck.name + "!", questions: []) // Question is not defined, so I'm using an empty array here.
            }
        }
    }
}
