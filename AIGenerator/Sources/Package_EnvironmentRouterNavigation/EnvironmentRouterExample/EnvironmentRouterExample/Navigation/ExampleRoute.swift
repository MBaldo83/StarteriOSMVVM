import Foundation

extension ExampleRouter {
    enum ExampleRoute: Hashable {
        case viewWithNoArguments
        case viewWithModel(item: SingleItem)
    }
}
