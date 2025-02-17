import Foundation

extension AiderControl {
    
    func makeCafeEndpoints() {
        let endpointBuilder = NewNetworkingEndpointCasePromptCreator(endpoint: .cafeAPI())
        promptPipelineRunner.inference(
            using: endpointBuilder,
            with: endpointBuilder
        )
        
        let clientBuilder = NewNetworkingClientPromptCreator(endpoint: .cafeAPI())
        promptPipelineRunner.inference(
            using: clientBuilder,
            with: clientBuilder
        )
    }
}
