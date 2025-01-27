import Foundation

extension MVVM.ViewSpecification {
    var modelVariablesString: String {
        let variables = models.map { "\($0.variableName) = \($0.modelType)" }
        return variables.joined(separator: " and ")
    }
}

extension MVVM.ViewSpecification {
    var domainModelFilePaths: [String] {
        return models.map { $0.modelPath }
    }
    
    var exampleViewPath: String {
        "\(AiderControl.Constants.aiGeneratorRoot)\(MVVMViewBuilder.Constants.exampleViewsRoot)\(exampleViewFileName)"
    }
    
    var exampleViewFileName: String {
        "\(exampleViewName).swift"
    }
    
    var exampleViewName: String {
        containsCollection ? "CollectionOfItemsView" : "SingleItemView"
    }
}

extension NewViewBuilder: PromptConfig {
    var filesToAdd: [String] {
        newView.domainModelFilePaths +
        [newView.exampleViewPath]
    }
}

extension MVVM.ViewSpecification {
    var containsCollection: Bool {
        models.contains(where: { $0.isCollection })
    }
}

struct NewViewBuilder: PromptCreator {
    
    let newView: MVVM.ViewSpecification
    
    func prompt() -> String {
    """
    Using \(newView.exampleViewName) as an example, make a new view \(newView.viewName) in \(newView.viewFolderPath) \
    that is initialised with variables: \(newView.modelVariablesString). \
    Using \(newView.exampleViewName)ViewModel as an example, make a \(newView.viewName)ViewModel in the same file as \(newView.viewName) \
    This is a first draft, keep the solution simple. IMPORTANT: implement the solution without asking any questions
    """
    }
}

struct MVVMViewBuilder {
    enum Constants {
        static let exampleViewsRoot = "Sources/Package_MVVMViewBuilder/MVVMExample/MVVMExample/Views/"
    }
}
