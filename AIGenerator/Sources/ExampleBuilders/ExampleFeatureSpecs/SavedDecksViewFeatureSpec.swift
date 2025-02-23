import Foundation

extension MVVM.ViewSpecification {
    static func savedDecksViewFeatureSpec() -> MVVM.ViewSpecification {
        .init(
            viewName: "SavedDecksView",
            viewFolderPath: "\(AiderControl.Constants.appModuleRoot)Views/",
            models: [
                .init(
                    variableName: "savedDecks",
                    modelType: "LocalDeck",
                    modelPath: "\(AiderControl.Constants.appModuleRoot)Domain/LocalDeck.swift",
                    isCollection: true
                )
            ]
        )
    }
}
