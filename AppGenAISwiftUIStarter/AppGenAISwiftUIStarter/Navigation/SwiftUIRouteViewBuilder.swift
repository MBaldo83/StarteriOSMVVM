import SwiftUI

class SwiftUIRouteViewBuilder {
    
    let viewModelFactory: ViewModelFactory
    
    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    @MainActor
    @ViewBuilder
    func view(for route: Router.Route) -> some View {

        switch route {
            
        case .deckDetails(let deck):
            DeckDetailsView(viewModel: .init(deck: deck))
            
        case .cafeProductDetail(let product):
            CafeProductDetailView(
                viewModel: viewModelFactory.cafeDetailViewModel(
                    product: product
                )
            )
            
        case .cafeProductsList:
            CafeProductsView(
                viewModel: self.viewModelFactory.cafeProductsViewModel()
            )
            
        case .savedDecks:
            SavedDecksView(
                viewModel: .init( // Could move this to the factory if necessary
                    decks: [
                        .init(
                            id: UUID(),
                            name: "deck 1",
                            questions: [
                                .init(id: UUID(), question: "question 1", answer: "answer 1"),
                                .init(id: UUID(), question: "question 2", answer: "answer 2")
                            ]
                        ),
                        .init(
                            id: UUID(),
                            name: "deck 2",
                            questions: [
                                .init(id: UUID(), question: "question 1", answer: "answer 1"),
                                .init(id: UUID(), question: "question 2", answer: "answer 2")
                            ]
                        )
                    ]
                )
            )
            
        case .deckGenerator:
            DeckGeneratorView(viewModel: .init(questions: []))
        }
    }
}
