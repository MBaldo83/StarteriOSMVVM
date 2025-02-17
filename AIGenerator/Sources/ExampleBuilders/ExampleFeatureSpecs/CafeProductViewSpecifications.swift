import Foundation

extension MVVM.ViewSpecification {
    static func cafeProductsListViewSpec() -> MVVM.ViewSpecification {
        .init(
            viewName: "CafeProductsView",
            viewFolderPath: "\(AiderControl.Constants.appModuleRoot)Views/",
            models: [
                .init(
                    variableName: "products",
                    modelType: "CafeProduct",
                    modelPath: "\(AiderControl.Constants.appModuleRoot)Domain/CafeProduct.swift",
                    isCollection: true
                )
            ]
        )
    }
    
    static func cafeProductsDetailsViewSpec() -> MVVM.ViewSpecification {
        .init(
            viewName: "CafeProductDetailView",
            viewFolderPath: "\(AiderControl.Constants.appModuleRoot)Views/",
            models: [
                .init(
                    variableName: "product",
                    modelType: "CafeProduct",
                    modelPath: "\(AiderControl.Constants.appModuleRoot)Domain/CafeProduct.swift",
                    isCollection: false
                )
            ]
        )
    }
}
