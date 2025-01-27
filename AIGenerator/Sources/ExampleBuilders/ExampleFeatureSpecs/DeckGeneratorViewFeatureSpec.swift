import Foundation

extension MVVM.ViewSpecification {
    static func deckGeneratorViewFeatureSpec() -> MVVM.ViewSpecification {
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
