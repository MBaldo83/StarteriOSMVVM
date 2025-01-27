import SwiftUI

@main
struct EnvironmentRouterExampleApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView(
                router: ExampleRouter(
                    routeViewBuilder: ExampleSwiftUIRouteViewBuilder()
                )
            ) {
                HomeView()
            }
        }
    }
}
