import Foundation

extension ViewSpecification {
    var modelVariablesString: String {
        let variables = models.map { "\($0.variableName) = \($0.modelType)" }
        return variables.joined(separator: " and ")
    }
}

extension ViewSpecification {
    var filesNeededToCreate: [String] {
        return models.map { $0.modelPath }
    }
    
    var exampleViewPath: String {
        "\(AiderControl.Constants.aiGeneratorRoot)\(MVVMViewBuilder.Constants.exampleViewsRoot)\(exampleViewFileName)"
    }
    
    private var exampleViewFileName: String {
        containsCollection ? "SingleItemView.swift" : "CollectionOfItemsView.swift"
    }
}

extension NewViewBuilder: PromptConfig {
    var filesToAdd: [String] {
        newView.filesNeededToCreate +
        [newView.exampleViewPath]
    }
}

extension ViewSpecification {
    var containsCollection: Bool {
        models.contains(where: { $0.isCollection })
    }
}

struct NewViewBuilder: PromptCreator {
    
    let newView: ViewSpecification
    
    func prompt() -> String {
        newView.containsCollection ? collectionItemViewPrompt : singleItemViewPrompt
    }
    
    private var singleItemViewPrompt: String {
                """
        Using SingleItemView as an example, make a new view \(newView.viewName) in \(newView.viewFolderPath) \
        that is initialised with variables: \(newView.modelVariablesString). \
        make a \(newView.viewName)ViewModel in the same file as \(newView.viewName) \
        This is a first draft, keep the solution simple. IMPORTANT: implement the solution without asking any questions
        """
    }
    
    private var collectionItemViewPrompt: String {
                """
        Using CollectionOfItemsView as an example, make a new view \(newView.viewName) in \(newView.viewFolderPath) \
        that is initialised with variables: \(newView.modelVariablesString). \
        make a \(newView.viewName)ViewModel in the same file as \(newView.viewName) \
        This is a first draft, keep the solution simple. IMPORTANT: implement the solution without asking any questions
        """
    }
    
}

struct MVVMViewBuilder {
    enum Constants {
        static let exampleViewsRoot = "Sources/Package_MVVMViewBuilder/MVVMExample/MVVMExample/Views/"
    }
}
