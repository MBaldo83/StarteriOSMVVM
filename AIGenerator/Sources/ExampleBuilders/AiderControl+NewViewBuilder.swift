import Foundation

extension AiderControl {
    
    func runDeckGeneratorViewBuilder() {
        let viewBuilder = NewViewBuilder(newView: .deckGeneratorViewFeatureSpec())
        promptPipelineRunner.inference(
            using: viewBuilder,
            with: viewBuilder
        )
    }
    
    func runSavedDecksViewBuilder() {
        let viewBuilder = NewViewBuilder(newView: .savedDecksViewFeatureSpec())
        promptPipelineRunner.inference(
            using: viewBuilder,
            with: viewBuilder
        )
    }
}
