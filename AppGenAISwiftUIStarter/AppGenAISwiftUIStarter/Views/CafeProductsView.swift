import SwiftUI

struct CafeProductsView: View {
    @Environment(Router.self) private var router: Router
    
    @State var viewModel: ViewModel
    
    var body: some View {
        CafeProductsContentView(
            products: viewModel.products,
            viewActionOne: viewModel.viewActionOne,
            onProductTap: { product in
                router.navigateTo(.cafeProductDetail(product: product))
            }
        )
    }
}

// This can be used in Previews
struct CafeProductsContentView: View {
    
    let products: [CafeProduct]
    let viewActionOne: () -> Void
    let onProductTap: (CafeProduct) -> Void
    
    var body: some View {
        VStack {
            Button(
                "View Action 1",
                action: viewActionOne
            )
            ForEach(products, id: \.self) { product in
                Button {
                    onProductTap(product)
                } label: {
                    VStack {
                        Text("Name: \(product.name)")
                        Text("Count: \(products.count)")
                    }
                }
            }
        }
    }
}

extension CafeProductsView {
    
    @Observable
    class ViewModel {
        
        var products: [CafeProduct]
        
        init(products: [CafeProduct]) {
            self.products = products
        }
        
        func viewActionOne() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let currentTime = dateFormatter.string(from: Date())
//            products.append(.mock(title: currentTime))
        }
    }
}
