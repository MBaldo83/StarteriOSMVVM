import SwiftUI

class NavigationStackViewFactory {
    
    @MainActor
    @ViewBuilder
    func make() -> some View {
        RouterView(
            router: Router(
                routeViewBuilder: SwiftUIRouteViewBuilder()
            )
        ) {
            Text("Navigation Stack")
        }
        .tabItem {
            Image(systemName: "map")
            Text("Stack")
        }
    }
}
