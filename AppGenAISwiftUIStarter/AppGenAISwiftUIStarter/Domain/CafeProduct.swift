import Foundation

struct CafeProduct {
    let type: FoodType
    let name: String
    let description: String
    
    enum FoodType {
        case drink
        case snack
    }
}
