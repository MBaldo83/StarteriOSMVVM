import SwiftUI

@main
struct AppGenAISwiftUIStarterApp: App {
    
    let factoryStore = AppDependenciesFactoryStore()
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    
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
            .environment(
                \.managedObjectContext,
                 persistenceController.container.viewContext
            )
        }
        .onChange(of: scenePhase) {
            persistenceController.save()
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
