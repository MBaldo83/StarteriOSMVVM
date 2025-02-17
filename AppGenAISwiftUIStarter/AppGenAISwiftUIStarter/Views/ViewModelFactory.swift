import Foundation

class ViewModelFactory {
    
    let clientFactory: DataClientsFactory
    private weak var currentCafeProductsViewModel: CafeProductsView.ViewModel?
    
    init(clientFactory: DataClientsFactory) {
        self.clientFactory = clientFactory
    }
    
    func cafeProductsViewModel() -> CafeProductsView.ViewModel {
        
        let useCase = OutputDelegateGetCafeProductsUseCase(
            cafeClient: clientFactory.getCafeProductsClient()
        )
        
        let viewModel = CafeProductsView.ViewModel(
            products: [],
            getProductsUseCase: useCase
        )
        
        useCase.output = viewModel
        currentCafeProductsViewModel = viewModel
        return viewModel
    }
    
    func cafeDetailViewModel(product: CafeProduct) -> CafeProductDetailView.ViewModel {
        
        let useCase = OutputDelegateUpdateCafeProductUseCase(
            cafeClient: clientFactory.getCafeProductsClient()
        )
        
        let viewModel = CafeProductDetailView.ViewModel(
            product: product,
            updateUseCase: useCase
        )
    
        viewModel.productUpdated = { result in
            await self.currentCafeProductsViewModel?.updateProductComplete(result)
        }
        
        useCase.output = viewModel
        
        return viewModel
    }
}
