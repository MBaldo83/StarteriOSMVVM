import SwiftUI

@MainActor
class SwiftUIRouteViewBuilder {
    
    @ViewBuilder
    func view(for route: Router.Route) -> some View {

        switch route {
        case .deckDetails(let deck):
            DeckDetailsView(viewModel: .init(deck: deck))
        }
    }
}
