import Foundation

extension AiderControl {
    enum Constants {
        static let appModuleRoot = "AppGenAISwiftUIStarter/AppGenAISwiftUIStarter/"
        static let aiGeneratorRoot = "AIGenerator/"
    }
}

struct AiderControl {
    
    //.dryRunPipeline()
    //.aiderProductionPipeline()
    var promptPipelineRunner: PromptPipelineRunner = PromptPipelineRunnerFactory.aiderProductionPipeline()
    
    /**
     Control your generation by editing the commands below.
     */
    func run() {
        
        runCafeProductsToDetailsNavigationBuilder()
        
        /**
         Below is a list of previous commands for reference
         */
        
//        runSavedDecksViewBuilder()
//        runSavedDecksToDeckDetailNavigationBuilder()
//        runDeckDetailViewBuilder()
//        runSavedDecksViewBuilder()
//        runDeckGeneratorViewBuilder()
        
    }
}
