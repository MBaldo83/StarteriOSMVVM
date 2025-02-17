import SwiftUI

struct SavedDecksView: View {
    
    @State var viewModel: ViewModel
    @Environment(Router.self) private var router: Router
    @Environment(ModalRouter.self) private var modalRouter: ModalRouter
    
    var body: some View {
        SavedDecksContentView(
            decks: viewModel.decks,
            presentGenerator: {
                modalRouter.present(.deckGenerator)
            },
            navigateToDeckDetails: { deck in
                router.navigateTo(.deckDetails(deck: deck))
            }
        )
    }
}

struct SavedDecksContentView: View {
    let decks: [LocalDeck]
    let presentGenerator: () -> Void
    let navigateToDeckDetails: (LocalDeck) -> Void

    var body: some View {
        VStack {
            Button(action: presentGenerator) {
                Text("Generate")
            }
            ForEach(decks) { deck in
                Button(action: {
                    navigateToDeckDetails(deck)
                }) {
                    Text(deck.name)
                }
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
