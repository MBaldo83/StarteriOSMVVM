import SwiftUI

@MainActor
class ExampleSwiftUIRouteViewBuilder {
    
    @ViewBuilder
    func view(for route: ExampleRouter.ExampleRoute) -> some View {
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
