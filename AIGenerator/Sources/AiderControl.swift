import Foundation

protocol PromptPipelineRunner {
    func inference(
        using promptCreator: PromptCreator,
        with config: PromptConfig
    )
}

extension AiderControl {
    enum Constants {
        static let appModuleRoot = "AppGenAISwiftUIStarter/AppGenAISwiftUIStarter/"
        static let aiGeneratorRoot = "AIGenerator/"
    }
}

struct AiderControl {
    
    var promptPipelineRunner: PromptPipelineRunner = PromptPipelineRunnerFactory.aiderProductionPipeline()
    
    /**
     Control your generation by editing the commands below.
     */
    func run() {
        
        runSavedDecksViewBuilder()
        
        /** Generation History **/
//        runDeckGeneratorViewBuilder()
        
    }
}
