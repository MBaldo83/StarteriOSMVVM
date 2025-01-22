import Foundation

extension ViewSpecification {
    static func deckGeneratorViewFeatureSpec() -> ViewSpecification {
        .init(
            viewName: "DeckGeneratorView",
            viewFolderPath: "\(AiderControl.Constants.appProjectRoot)Views/DeckGeneratorView/",
            models: [
                .init(
                    variableName: "generatedQuestions",
                    modelType: "Question",
                    modelPath: "\(AiderControl.Constants.appProjectRoot)Domain/Question.swift",
                    isCollection: true
                )
            ]
        )
    }
}
