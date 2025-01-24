import Foundation

struct NavigationLink {
    let from: ViewSpecification
    let to: ViewSpecification
    let triggerDescription: String
    let dataMappings: [DataMapping]
    
    struct DataMapping {
        let use: String
        let toCreate: String
    }
    
    struct ViewSpecification {
        let viewName: String
        let viewFolderPath: String
        let models: [ViewData]
        
        struct ViewData {
            let variableName: String
            let modelType: String
            let modelPath: String
            var isCollection: Bool = false
        }
    }
}
