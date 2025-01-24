import SwiftUI

@main
struct AppGenAISwiftUIStarterApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView(
                buildTabZero: {
                    Text("Tab 0")
                },
                buildTabOne: {
                    Text("Tab 1")
                },
                buildTabTwo: {
                    Text("Tab 2")
                }
            )
        }
    }
}
