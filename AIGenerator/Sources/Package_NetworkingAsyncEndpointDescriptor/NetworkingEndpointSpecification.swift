import Foundation

struct NetworkingEndpointSpecification {
    let apiEndpointDefinitionInProject: EntityInfo
    let apiClientInProject: EntityInfo
    let endpointURLDescription: String
    let mappings: [ResponseMapping]
    
    struct ResponseMapping {
        let httpEndpoint: String
        let responseMappingModelName: String
        let domainModelName: String
        let domainModelFilePath: String
    }
    
    struct EntityInfo {
        let filePath: String
        let name: String
    }
}
