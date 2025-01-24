import SwiftUI

@MainActor
class SwiftUIRouteViewBuilder {
    
    @ViewBuilder
    func view(for route: Router.Route) -> some View {
        switch route {
        case .viewWithNoArguments:
            SingleItemView(
                viewModel: .init(item: .mock())
            )
        case .viewWithModel(let item):
            SingleItemView(
                viewModel: .init(item: item)
            )
        }
    }
}
