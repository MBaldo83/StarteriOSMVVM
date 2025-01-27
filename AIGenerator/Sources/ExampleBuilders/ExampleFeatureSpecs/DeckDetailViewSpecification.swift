import Foundation

extension MVVM.ViewSpecification {
    static func deckDetailViewSpecification() -> MVVM.ViewSpecification {
        .init(
            viewName: "DeckDetailsView",
            viewFolderPath: "\(AiderControl.Constants.appModuleRoot)Views/",
            models: [
                .init(
                    variableName: "deck",
                    modelType: "LocalDeck",
                    modelPath: "\(AiderControl.Constants.appModuleRoot)Domain/LocalDeck.swift",
                    isCollection: false
                )
            ]
        )
    }
}
