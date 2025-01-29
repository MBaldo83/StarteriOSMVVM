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
        
        runSavedDecksToDeckDetailNavigationBuilder()
//        runDeckDetailViewBuilder()
//        runSavedDecksViewBuilder()
//        runDeckGeneratorViewBuilder()
        
    }
}
