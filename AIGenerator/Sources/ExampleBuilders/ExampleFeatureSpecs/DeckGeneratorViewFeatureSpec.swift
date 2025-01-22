import Foundation

extension ViewSpecification {
    static func deckGeneratorViewFeatureSpec() -> ViewSpecification {
        .init(
            viewName: "DeckGeneratorView",
            viewFolderPath: "\(AiderControl.Constants.appModuleRoot)Views/",
            models: [
                .init(
                    variableName: "generatedQuestions",
                    modelType: "Question",
                    modelPath: "\(AiderControl.Constants.appModuleRoot)Domain/Question.swift",
                    isCollection: true
                )
            ]
        )
    }
}
