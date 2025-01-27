import Foundation

extension ExampleRouter {
    enum Route: Hashable {
        case viewWithNoArguments
        case viewWithModel(item: SingleItem)
    }
}
