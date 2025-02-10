import SwiftUI

class SingleViewFactory {
    
    @MainActor
    @ViewBuilder
    func make() -> some View {
        RouterView(
            router: Router(
                routeViewBuilder: SwiftUIRouteViewBuilder()
            )
        ) {
            CafeProductsView(
                viewModel: .init(
                    products: [
                        .init(type: .drink, name: "Espresso", description: "Short blast of delicious Coffee."),
                        .init(type: .drink, name: "Machiato", description: "Espresso but with just a touch of foamed milk."),
                        .init(type: .snack, name: "Chocolate Biscuit", description: "Dark Chocolate with a hint of spice")
                    ]
                )
            )
        }
        .tabItem {
            Image(systemName: "mappin.circle")
            Text("Single")
        }
    }
}
