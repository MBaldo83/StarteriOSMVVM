import Foundation

protocol GetCafeProductsUseCase {
    func getCafeProducts()
}

protocol GetCafeProductsUseCaseOutput: AnyObject {
    func getProductsComplete(_ result: Result<[CafeProduct], Error>) async
}

class OutputDelegateGetCafeProductsUseCase: GetCafeProductsUseCase {
    
    // Property designed as a delegate that should be assigned after initialisation
    weak var output: GetCafeProductsUseCaseOutput?
    
    let cafeClient: CafeProductsClient
    
    init(
        cafeClient: CafeProductsClient
    ) {
        self.cafeClient = cafeClient
    }
    
    func getCafeProducts() {
        Task {
            let result = await cafeClient.getProducts(maxResults: 10)
            await output?.getProductsComplete(result)
        }
    }
}
