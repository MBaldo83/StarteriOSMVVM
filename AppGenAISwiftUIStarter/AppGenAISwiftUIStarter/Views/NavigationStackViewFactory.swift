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
            Text("Tab 0")
        }
        .tabItem {
            Image(systemName: "map")
            Text("Stack")
        }
    }
}
