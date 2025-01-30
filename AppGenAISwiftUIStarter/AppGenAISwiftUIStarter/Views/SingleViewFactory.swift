import SwiftUI

class SingleViewFactory {
    
    @MainActor
    @ViewBuilder
    func make() -> some View {
        Text("Single View")
            .tabItem {
                Image(systemName: "mappin.circle")
                Text("Single")
            }
    }
}
