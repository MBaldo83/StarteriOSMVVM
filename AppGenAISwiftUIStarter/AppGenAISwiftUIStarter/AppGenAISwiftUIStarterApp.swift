import SwiftUI

@main
struct AppGenAISwiftUIStarterApp: App {
    
    let factoryStore = AppDependenciesFactoryStore()
    
    var body: some Scene {
        WindowGroup {
            RootTabView(
                buildTabZero: {
                    DecksTabRootViewFactory(
                        viewBuilder: factoryStore.routeViewBuilder
                    ).make()
                },
                buildTabOne: {
                    CafeRootTabViewFactory(
                        viewBuilder: factoryStore.routeViewBuilder
                    ).make()
                },
                buildTabTwo: {
                    RelaxTabViewFactory().make()
                }
            )
        }
    }
}

class AppDependenciesFactoryStore {
    
    lazy var routeViewBuilder: SwiftUIRouteViewBuilder = {
        SwiftUIRouteViewBuilder(
            viewModelFactory: ViewModelFactory(
                clientFactory: .init(
                    networkingFactory: .init()
                )
            )
        )
    }()
}
