import Foundation

extension ViewSpecification {
    static func savedDecksViewFeatureSpec() -> ViewSpecification {
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
