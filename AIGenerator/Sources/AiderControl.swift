import Foundation

protocol PromptPipelineRunner {
    func inference(
        using promptCreator: PromptCreator,
        with config: PromptConfig
    )
}

extension AiderControl {
    enum Constants {
        static let appProjectRoot = "Swot_It/SwotItApp/"
        static let aiGeneratorRoot = "AIGenerator/"
    }
}

struct AiderControl {
    
    var promptPipelineRunner: PromptPipelineRunner = PromptPipelineRunnerFactory.dryRunPipeline()
    
    /**
     Control your generation by editing the commands below.
     */
    func run() {
        
        runSavedDecksViewBuilder()
        runDeckGeneratorViewBuilder()
        
/** Generation History **/
//        generateMocksForDomainDataModels()
//        generateViewHandlerUnitTests()
//        generateDeckResultsNavigation()
    }
}
