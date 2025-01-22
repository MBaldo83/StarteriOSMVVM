import Foundation

extension ViewSpecification {
    static func savedDecksViewFeatureSpec() -> ViewSpecification {
        .init(
            viewName: "SavedDecksView",
            viewFolderPath: "\(AiderControl.Constants.appProjectRoot)Views/SavedDecksView/",
            models: [
                .init(
                    variableName: "savedDecks",
                    modelType: "LocalDeck",
                    modelPath: "\(AiderControl.Constants.appProjectRoot)Domain/Question.swift",
                    isCollection: true
                )
            ]
        )
    }
}
