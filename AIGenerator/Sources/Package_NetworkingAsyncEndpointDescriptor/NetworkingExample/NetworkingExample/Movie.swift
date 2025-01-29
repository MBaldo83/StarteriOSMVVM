import Foundation

// This is the domain model it is used by the view model
// but is not the model decoded from the network request
struct Movie {
    let title: String
    let id: Int
}
