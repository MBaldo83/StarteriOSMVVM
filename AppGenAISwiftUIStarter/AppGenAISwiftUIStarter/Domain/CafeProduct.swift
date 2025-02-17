import Foundation

struct CafeProduct: Hashable {
    let id: Int
    var type: FoodType
    var name: String
    var description: String
    
    enum FoodType: Hashable {
        case drink
        case snack
    }
}
