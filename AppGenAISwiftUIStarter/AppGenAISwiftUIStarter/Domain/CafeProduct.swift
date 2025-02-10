import Foundation

struct CafeProduct: Hashable {
    let type: FoodType
    let name: String
    let description: String
    
    enum FoodType: Hashable {
        case drink
        case snack
    }
}
