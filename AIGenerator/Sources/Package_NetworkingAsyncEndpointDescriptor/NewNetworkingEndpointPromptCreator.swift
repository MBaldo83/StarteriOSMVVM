import Foundation

struct NewNetworkingEndpointCasePromptCreator: PromptCreator {
    
    let endpoint: NetworkingEndpointSpecification
    
    func prompt() -> String {
        """
Following the example of ExampleMoviesAPI, using \(endpoint.endpointURLDescription) for endpoint details \
add new cases to \(endpoint.apiEndpointDefinitionInProject.name). \(endpoint.endpointToDecodableModelMappingConjunctions). \
For each endpoint, all responses should be mapped to a decodable response struct seperate to the domain model like ExamplePopularMoviesResponse \
Only decode the values required by the domain model.
"""
    }
}

extension NetworkingEndpointSpecification {
    
    var endpointToDecodableModelMappingConjunctions: String {
        let variables = mappings.map { "\($0.httpEndpoint) will map to \($0.responseMappingModelName)" }
        return variables.joined(separator: " and ")
    }
}

extension NewNetworkingEndpointCasePromptCreator: PromptConfig {
    
    var domainModelFilePaths: [String] {
        return endpoint.mappings.map { $0.domainModelFilePath }
    }
    
    var filesToAdd: Set<String> {
        Set(domainModelFilePaths + 
            [endpoint.apiEndpointDefinitionInProject.filePath] + 
            ["\(NetworkingAsyncEndpoint.Constants.networkingExampleRoot)ExampleMoviesAPI.swift"])
    }
}

struct NetworkingAsyncEndpoint {
    enum Constants {
        static let networkingExampleRoot = "\(AiderControl.Constants.aiGeneratorRoot)Sources/Package_NetworkingAsyncEndpointDescriptor/NetworkingExample/NetworkingExample/"
    }
}
