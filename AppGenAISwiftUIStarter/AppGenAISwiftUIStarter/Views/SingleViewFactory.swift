import SwiftUI

class SingleViewFactory {
    
    @MainActor
    @ViewBuilder
    func make() -> some View {
        Text("Tab 1")
            .tabItem {
                Image(systemName: "mappin.circle")
                Text("Single")
            }
    }
}
