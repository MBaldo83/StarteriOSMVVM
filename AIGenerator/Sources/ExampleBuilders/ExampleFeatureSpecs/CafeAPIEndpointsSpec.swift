import Foundation

extension NetworkingEndpointSpecification {
    static func cafeAPI() -> NetworkingEndpointSpecification {
        NetworkingEndpointSpecification(
            apiEndpointDefinitionInProject: .init(
                filePath: "\(AiderControl.Constants.appModuleRoot)Repositories/CafeProductsAPI.swift",
                name: "CafeProductsAPI"
            ), apiClientInProject: .init(
                filePath: "\(AiderControl.Constants.appModuleRoot)Repositories/CafeProductsClient.swift",
                name: "CafeProductsClient"
            ),
            endpointURLDescription: "http://localhost:8001/openapi.json",
            mappings: [
                .init(
                    httpEndpoint: "/products",
                    responseMappingModelName: "Array of DecodableCafeProduct",
                    domainModelName: "Array of CafeProduct",
                    domainModelFilePath: "\(AiderControl.Constants.appModuleRoot)Domain/CafeProduct.swift"
                ),
                .init(
                    httpEndpoint: "/products/{product_id} -> GET",
                    responseMappingModelName: "DecodableCafeProduct",
                    domainModelName: "CafeProduct",
                    domainModelFilePath: "\(AiderControl.Constants.appModuleRoot)Domain/CafeProduct.swift"
                ),
                .init(
                    httpEndpoint: "/products/{product_id} PUT",
                    responseMappingModelName: "DecodableCafeProduct",
                    domainModelName: "CafeProduct",
                    domainModelFilePath: "\(AiderControl.Constants.appModuleRoot)Domain/CafeProduct.swift"
                )
            ]
        )
    }
}
