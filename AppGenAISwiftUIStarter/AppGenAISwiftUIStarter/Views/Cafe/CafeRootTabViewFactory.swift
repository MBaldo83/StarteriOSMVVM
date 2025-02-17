import SwiftUI

class CafeRootTabViewFactory {
    
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
            ),
            modalRouter: ModalRouter()
        ) {
            self.viewBuilder.view(for: .cafeProductsList)
        }
        .tabItem {
            Image(systemName: "cup.and.saucer.fill")
            Text("Cafe")
        }
    }
}
