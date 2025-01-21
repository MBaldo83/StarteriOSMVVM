import Foundation

extension ViewSpecification {
    static func deckReviewViewFeatureSpec() -> ViewSpecification {
        .init(
            viewName: "DeckReviewView",
            viewFolderPath: "Swot_It/SwotItApp/Views/DeckReviewView/",
            models: [
                .init(
                    variableName: "viewState",
                    modelType: "DeckViewState",
                    modelPath: "Swot_It/SwotItApp/Views/DeckReviewView/DeckReviewView.swift"
                )
            ]
        )
    }
}
