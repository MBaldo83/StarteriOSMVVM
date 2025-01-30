import SwiftUI

struct HomeView: View {
    
    @State var router: Router = Router()
    
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $router.routePath) {
            List {
                Button("Single Item") {
                    router.navigateTo(.singleItem)
                }
                Button("Collection Of Items") {
                    router.navigateTo(.collectionOfItems)
                }
                Button("TODO: Collection Modified By Navigation Child") {
                    router.navigateTo(.collectionModifiedNavChild)
                }
            }
            .navigationDestination(for: Router.ExampleRoute.self) { route in
                router.view(for: route)
            }
            .navigationTitle("Home")
        }
    }
}

extension Router {
    enum ExampleRoute: Hashable {
        case singleItem
        case collectionOfItems
        case collectionModifiedNavChild
    }
}

extension Router {
    @ViewBuilder
    func view(for route: ExampleRoute) -> some View {
        switch route {
        case .singleItem:
            SingleItemView(
                viewModel: .init(item: .mock())
            )
        case .collectionOfItems:
            CollectionOfItemsView(
                viewModel: .init(
                    itemsCollection: [
                        .mock(title: "Mock Item 1"),
                        .mock(title: "Mock Item 2")
                    ]
                )
            )
        case .collectionModifiedNavChild:
            Text("TODO")
        }
    }
}

extension SingleItem {
    static func mock(
        title: String = "Mock Item",
        count: Int = 42
    ) -> SingleItem {
        SingleItem(title: title, count: count)
    }
}

#Preview {
    HomeView()
}
