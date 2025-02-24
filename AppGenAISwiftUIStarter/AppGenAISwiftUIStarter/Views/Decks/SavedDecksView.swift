import SwiftUI
import CoreData

struct SavedDecksView: View {
    @Environment(Router.self) private var router: Router
    @Environment(ModalRouter.self) private var modalRouter: ModalRouter
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var decks: FetchedResults<Deck>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        SavedDecksContentView(
            decks: decks,
            presentGenerator: {
                modalRouter.present(.deckGenerator)
            },
            navigateToDeckDetails: { deck in
                router.navigateTo(.deckDetails(deck: deck))
            },
            deleteDeck: { $0.delete(in: context) }
        )
    }
}

struct SavedDecksContentView: View {
    let decks: FetchedResults<Deck>
    let presentGenerator: () -> Void
    let navigateToDeckDetails: (Deck) -> Void
    let deleteDeck: (Deck) -> Void
    
    var body: some View {
        ZStack {
            // Main content
            List {
                ForEach(decks) { deck in
                    Button(action: {
                        navigateToDeckDetails(deck)
                    }) {
                        HStack {
                            Text(deck.name ?? "")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            
            // Bottom button
            VStack {
                Spacer()
                Button(action: presentGenerator) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Generate New Deck")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let deckToDelete = decks[index]
            deleteDeck(deckToDelete)
        }
    }
}
