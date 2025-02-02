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
    var promptPipelineRunner: PromptPipelineRunner = PromptPipelineRunnerFactory.dryRunPipeline()
    
    /**
     Control your generation by editing the commands below.
     */
    func run() {
        
        runSavedDecksViewBuilder()
        
        /**
         Below is a list of previous commands for reference
         */
//        runSavedDecksToDeckDetailNavigationBuilder()
//        runDeckDetailViewBuilder()
//        runSavedDecksViewBuilder()
//        runDeckGeneratorViewBuilder()
        
    }
}
