import Foundation

protocol UpdateCafeProductUseCase {
    func updateProduct(_ product: CafeProduct)
}

protocol UpdateCafeProductUseCaseOutput: AnyObject {
    func updateProductComplete(_ result: Result<CafeProduct, Error>) async
}

class OutputDelegateUpdateCafeProductUseCase: UpdateCafeProductUseCase {
    
    // Property designed as a delegate that should be assigned after initialisation
    weak var output: UpdateCafeProductUseCaseOutput?
    
    let cafeClient: CafeProductsClient
    
    init(
        cafeClient: CafeProductsClient
    ) {
        self.cafeClient = cafeClient
    }
    
    func updateProduct(_ product: CafeProduct) {
        Task {
            let result = await cafeClient.updateProduct(productId: product.id, product: product)
            await output?.updateProductComplete(result)
        }
    }
}
