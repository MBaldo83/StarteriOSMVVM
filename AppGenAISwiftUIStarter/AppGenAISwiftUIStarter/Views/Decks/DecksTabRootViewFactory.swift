import SwiftUI

class DecksTabRootViewFactory {
    
    let viewBuilder: SwiftUIRouteViewBuilder
    
    init(viewBuilder: SwiftUIRouteViewBuilder) {
        self.viewBuilder = viewBuilder
    }
    
    @MainActor
    @ViewBuilder
    func make() -> some View {
        RouterView(
            router: Router(
                routeViewBuilder: viewBuilder
            )
        ) {
            self.viewBuilder.view(for: .savedDecks)
        }
        .tabItem {
            Image(systemName: "map")
            Text("Decks")
        }
    }
}
