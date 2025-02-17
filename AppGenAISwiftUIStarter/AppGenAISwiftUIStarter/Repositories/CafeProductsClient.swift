import Foundation

protocol CafeProductsClient {
    func getProducts(maxResults: Int?) async -> Result<[CafeProduct], Error>
    func getProductById(productId: Int) async -> Result<CafeProduct, Error>
    func updateProduct(productId: Int, product: CafeProduct) async -> Result<CafeProduct, Error>
}

class NetworkingCafeProductsClient {
    let networking: DecodingEndpointAsyncNetwork
    init(networking: DecodingEndpointAsyncNetwork) {
        self.networking = networking
    }
}

extension NetworkingCafeProductsClient: CafeProductsClient {

    func getProducts(maxResults: Int?) async -> Result<[CafeProduct], Error> {
        await networking.send(
            CafeProductsAPI.getProducts(maxResults: maxResults),
            decodeTo: [CafeProductsAPI.DecodableCafeProduct].self
        ).map(
            successMap: { response in
                response.map { product in
                    CafeProduct(
                        id: product.id,
                        type: product.type.lowercased() == "drink" ? .drink : .snack,
                        name: product.name,
                        description: product.description
                    )
                }
            },
            errorMap: { $0 }
        )
    }

    func getProductById(productId: Int) async -> Result<CafeProduct, Error> {
        await networking.send(
            CafeProductsAPI.getProductById(productId: productId),
            decodeTo: CafeProductsAPI.DecodableCafeProduct.self
        ).map(
            successMap: { response in
                CafeProduct(
                    id: response.id,
                    type: response.type.lowercased() == "drink" ? .drink : .snack,
                    name: response.name,
                    description: response.description
                )
            },
            errorMap: { $0 }
        )
    }

    func updateProduct(productId: Int, product: CafeProduct) async -> Result<CafeProduct, Error> {
        let decodableProduct = CafeProductsAPI.DecodableCafeProduct(
            id: productId,
            name: product.name,
            description: product.description,
            type: product.type == .drink ? "drink" : "snack"
        )

        return await networking.send(
            CafeProductsAPI.updateProduct(productId: productId, product: decodableProduct),
            decodeTo: CafeProductsAPI.DecodableCafeProduct.self
        ).map(
            successMap: { product in
                CafeProduct(
                    id: product.id,
                    type: product.type.lowercased() == "drink" ? .drink : .snack,
                    name: product.name,
                    description: product.description
                )
            },
            errorMap: { $0 }
        )
    }
}
