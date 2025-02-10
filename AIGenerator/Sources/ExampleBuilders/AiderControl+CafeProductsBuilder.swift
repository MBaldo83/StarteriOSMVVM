import Foundation

extension AiderControl {
    
    func runCafeProductsViewBuilder() {
        let viewBuilder = NewViewBuilder(newView: .cafeProductsListViewSpec())
        promptPipelineRunner.inference(
            using: viewBuilder,
            with: viewBuilder
        )
    }
}
