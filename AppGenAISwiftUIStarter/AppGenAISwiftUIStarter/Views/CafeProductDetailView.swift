import SwiftUI

struct CafeProductDetailView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        CafeProductDetailContentView(
            product: viewModel.product,
            viewActionOne: viewModel.viewActionOne
        )
    }
}

struct CafeProductDetailContentView: View {
    
    let product: CafeProduct
    let viewActionOne: () -> Void
    
    var body: some View {
        VStack {
            Button(
                "View Action 1",
                action: viewActionOne
            )
            Text("Name: \(product.name)")
            Text("Description: \(product.description)")
        }
    }
}


extension CafeProductDetailView {
    
    @Observable
    class ViewModel {
        
        var product: CafeProduct
        
        init(product: CafeProduct) {
            self.product = product
        }
        
        func viewActionOne() {
//            var newProduct = product
//            newProduct.name = String(product.name.shuffled())
//            product = newProduct
        }
    }
}
