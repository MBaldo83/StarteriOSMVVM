import SwiftUI

struct CafeProductsView: View {
    @Environment(Router.self) private var router: Router
    @State var viewModel: ViewModel
    
    var body: some View {
        CafeProductsContentView(
            products: viewModel.products,
            onProductTap: { product in
                router.navigateTo(.cafeProductDetail(product: product))
            }
        )
    }
}

// This can be used in Previews
struct CafeProductsContentView: View {
    
    let products: [CafeProduct]
    let onProductTap: (CafeProduct) -> Void
    
    var body: some View {
        List(products, id: \.self) { product in
            Button {
                onProductTap(product)
            } label: {
                HStack {
                    Text(product.name)
                    Spacer()
                    Text("\(product.type.productsListCardLocalisedString)")
                }
            }
        }
    }
}


