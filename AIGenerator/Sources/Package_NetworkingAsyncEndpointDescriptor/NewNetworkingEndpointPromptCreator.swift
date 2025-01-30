import Foundation

struct NetworkingEndpointSpecificaiton {
    let apiName: String
    let apiFilePath: String
    let endpointURLDescription: String
    let mappings: [ResponseMapping]
    
    struct ResponseMapping {
        let httpEndpoint: String
        let domainModelName: String
        let domainModelFilePath: String
    }
}

struct NewNetworkingEndpointCasePromptCreator: PromptCreator {
    
    let endpoint: NetworkingEndpointSpecificaiton
    
    func prompt() -> String {
        """
Following the example of ExampleMoviesAPI, using \(endpoint.endpointURLDescription) for endpoint details \
add new cases to \(endpoint.apiName). \(endpoint.endpointToModelMappingConjunctions). \
For each endpoint, the response should be mapped to a decodable response struct seperate to the domain model \
Only decode the values required by the domain model.
"""
    }
}

extension NetworkingEndpointSpecificaiton {
    var endpointToModelMappingConjunctions: String {
        let variables = mappings.map { "\($0.httpEndpoint) will map to domain model \($0.domainModelName)" }
        return variables.joined(separator: " and ")
    }
}

extension NewNetworkingEndpointCasePromptCreator: PromptConfig {
    
    var domainModelFilePaths: [String] {
        return endpoint.mappings.map { $0.domainModelFilePath }
    }
    
    var filesToAdd: [String] {
        domainModelFilePaths +
        [endpoint.apiFilePath] +
        ["\(NetworkingAsyncEndpoint.Constants.networkingExampleRoot)ExampleMoviesAPI.swift"]
    }
}

struct NetworkingAsyncEndpoint {
    enum Constants {
        static let networkingExampleRoot = "Sources/Package_NetworkingAsyncEndpointDescriptor/NetworkingExample/NetworkingExample/"
    }
}
