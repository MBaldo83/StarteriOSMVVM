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
                Button("Single Item Data Modifying") {
                    router.navigateTo(.singleItemDataModifying)
                }
                Button("Collection Of Items") {
                    router.navigateTo(.collectionOfItems)
                }
                Button("Collection Of Items Data Modifying") {
                    router.navigateTo(.collectionOfItemsDataModifying)
                }
                Button("TODO: Collection Modified By Navigation Child") {
                    router.navigateTo(.collectionModifiedNavChild)
                }
            }
            .navigationDestination(for: Router.Route.self) { route in
                router.view(for: route)
            }
            .navigationTitle("Home")
        }
    }
}

extension Router {
    enum Route: Hashable {
        case singleItem
        case singleItemDataModifying
        case collectionOfItems
        case collectionOfItemsDataModifying
        case collectionModifiedNavChild
    }
}

extension Router {
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .singleItem:
            SingleItemView(
                viewModel: .init(item: .mock())
            )
        case .singleItemDataModifying:
            SingleItemDataModifyingView(
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
        case .collectionOfItemsDataModifying:
            CollectionOfItemsDataModifyingView(
                viewModel: .init(
                    itemsCollection: [
                        .mock(title: "Mock Item 1")
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
