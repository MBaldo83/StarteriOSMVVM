import Foundation

struct NewNetworkingClientPromptCreator: PromptCreator {
    
    let endpoint: NetworkingEndpointSpecification
    
    func prompt() -> String {
        """
Following the example of NetworkMoviesAPIClient, using \(endpoint.apiEndpointDefinitionInProject.name) for endpoint details \
add new methods to \(endpoint.apiClientInProject.name). \(endpoint.endpointToModelMappingConjunctions) \
This is a first draft, keep the solution simple. IMPORTANT: implement the solution without asking any questions
"""
    }
}

extension NetworkingEndpointSpecification {
    
    var endpointToModelMappingConjunctions: String {
        let variables = mappings.map { "\($0.httpEndpoint) will be decoded to \($0.responseMappingModelName) then the Result success block will map to \($0.domainModelName)." }
        return variables.joined(separator: " ")
    }
}

extension NewNetworkingClientPromptCreator: PromptConfig {
    
    var domainModelFilePaths: [String] {
        return endpoint.mappings.map { $0.domainModelFilePath }
    }
    
    var filesToAdd: Set<String> {
        Set(domainModelFilePaths +
            [endpoint.apiEndpointDefinitionInProject.filePath,
            endpoint.apiClientInProject.filePath,
            "\(NetworkingAsyncEndpoint.Constants.networkingExampleRoot)ExampleMoviesAPI.swift",
            "\(NetworkingAsyncEndpoint.Constants.networkingExampleRoot)NetworkMoviesAPIClient.swift"])
    }
}

