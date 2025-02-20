import SwiftUI

struct SavedDecksView: View {
    @Environment(Router.self) private var router: Router
    @Environment(ModalRouter.self) private var modalRouter: ModalRouter
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var decks: FetchedResults<Deck>
    
    var body: some View {
        SavedDecksContentView(
            decks: decks,
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
    let decks: FetchedResults<Deck>
    let presentGenerator: () -> Void
    let navigateToDeckDetails: (Deck) -> Void

    var body: some View {
        VStack {
            Button(action: presentGenerator) {
                Text("Generate")
            }
            ForEach(decks) { deck in
                Button(action: {
                    navigateToDeckDetails(deck)
                }) {
                    Text(deck.name ?? "")
                }
            }
        }
    }
}
