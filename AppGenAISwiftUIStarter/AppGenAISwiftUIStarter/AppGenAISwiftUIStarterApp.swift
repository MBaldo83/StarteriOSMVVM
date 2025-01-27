import SwiftUI

@main
struct AppGenAISwiftUIStarterApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView(
                buildTabZero: {
                    NavigationStackViewFactory().make()
                },
                buildTabOne: {
                    SingleViewFactory().make()
                },
                buildTabTwo: {
                    RelaxTabViewFactory().make()
                }
            )
        }
    }
}
