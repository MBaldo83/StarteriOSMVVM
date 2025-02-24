import Foundation

extension CafeProductsView {
    
    @Observable
    class ViewModel {
        
        var products: [CafeProduct]
        let getProductsUseCase: GetCafeProductsUseCase
        
        init(
            products: [CafeProduct],
            getProductsUseCase: GetCafeProductsUseCase
        ) {
            self.products = products
            self.getProductsUseCase = getProductsUseCase
            self.getProductsUseCase.getCafeProducts()
        }
    }
}

extension CafeProductsView.ViewModel: GetCafeProductsUseCaseOutput {
    func getProductsComplete(
        _ result: Result<[CafeProduct], any Error>
    ) async {
        switch result {
        case .success(let newProducts):
            products = newProducts
        case .failure(let failure):
            print("SQUAWK: \(failure)")
        }
    }
}

extension CafeProductsView.ViewModel: UpdateCafeProductUseCaseOutput {
    func updateProductComplete(_ result: Result<CafeProduct, any Error>) async {
        switch result {
        case .success(let newProduct):
            if let index = products.firstIndex(where: { $0.id == newProduct.id }) {
                products[index] = newProduct
            }
        case .failure:
            break
        }
    }
}

extension CafeProduct.FoodType {
    var productsListCardLocalisedString: String {
        switch self {
        case .drink:
            "drink"
        case .snack:
            "snack"
        }
    }
}
