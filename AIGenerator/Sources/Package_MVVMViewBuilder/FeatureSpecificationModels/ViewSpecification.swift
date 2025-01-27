import Foundation

enum MVVM {
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
