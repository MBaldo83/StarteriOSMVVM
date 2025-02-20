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
            DeckDetailsView(deck: deck)
            
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
            SavedDecksView()
            
        case .deckGenerator:
            DeckGeneratorView(name: "", deckDescription: "")
        }
    }
}
