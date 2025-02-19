import SwiftUI
import Combine

struct SavedDecksView: View {
    
    @StateObject var viewModel: ViewModel
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
            },
            deleteDeck: { deck in
                viewModel.deleteDeck(deck)
            }
        )
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct SavedDecksContentView: View {
    let decks: [LocalDeck]
    let presentGenerator: () -> Void
    let navigateToDeckDetails: (LocalDeck) -> Void
    let deleteDeck: (LocalDeck) -> Void
    
    var body: some View {
        ZStack {
            // Main content
            List {
                ForEach(decks) { deck in
                    Button(action: {
                        navigateToDeckDetails(deck)
                    }) {
                        HStack {
                            Text(deck.name)
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

extension SavedDecksView {
    
    class ViewModel: ObservableObject {
        var decks: [LocalDeck] {
            dataManager.localDecksArray
        }
        @Published private var dataManager: DataManager
        var anyCancellable: AnyCancellable? = nil
        
        init(dataManager: DataManager = DataManager.shared) {
            self.dataManager = dataManager
            
            anyCancellable = dataManager.objectWillChange.sink { [weak self] (_) in
                self?.objectWillChange.send()
            }
        }
        
        func viewActionOne() { }
        
        func onAppear() { }
        
        func deleteDeck(_ deck: LocalDeck) {
            dataManager.delete(deck: deck)
        }
    }
}
