import Foundation

extension CafeProductDetailView {
    
    @Observable
    class ViewModel {
        private var receivedProduct: CafeProduct
        private let updateUseCase: UpdateCafeProductUseCase
        var product: CafeProduct
        var productUpdated: ((Result<CafeProduct, any Error>) async -> Void)?
        
        init(product: CafeProduct,
             updateUseCase: UpdateCafeProductUseCase) {
            self.receivedProduct = product
            self.product = product
            self.updateUseCase = updateUseCase
        }
        
        func isSubmitEnabled() -> Bool {
            product != receivedProduct
        }
        
        func submitChanges() {
            updateUseCase.updateProduct(product)
        }
    }
}

extension CafeProductDetailView.ViewModel: UpdateCafeProductUseCaseOutput {
    func updateProductComplete(_ result: Result<CafeProduct, any Error>) async {
        switch result {
        case .success(let newProduct):
            receivedProduct = newProduct
            product = newProduct
        case .failure(let failure):
            print("SQUAWK: \(failure)")
        }
        await productUpdated?(result)
    }
}
