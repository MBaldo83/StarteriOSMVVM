import SwiftUI

@main
struct EnvironmentRouterExampleApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView(
                router: Router(
                    routeViewBuilder: SwiftUIRouteViewBuilder()
                )
            ) {
                HomeView()
            }
        }
    }
}
