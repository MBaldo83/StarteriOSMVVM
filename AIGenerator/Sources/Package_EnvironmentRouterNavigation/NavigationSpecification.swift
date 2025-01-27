import Foundation

enum EnvironmentRouterNavigation {
    
    struct NavigationLink {
        let from: ViewSpecification
        let to: ViewSpecification
        let triggerDescriptionWhen: String
        let dataMappings: [DataMapping]
        let routesPath: String
        let viewBuilderPath: String
        
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
}

