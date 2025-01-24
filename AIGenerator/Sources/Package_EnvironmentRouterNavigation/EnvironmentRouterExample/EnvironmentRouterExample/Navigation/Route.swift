import Foundation

extension Router {
    enum Route: Hashable {
        case viewWithNoArguments
        case viewWithModel(item: SingleItem)
    }
}
