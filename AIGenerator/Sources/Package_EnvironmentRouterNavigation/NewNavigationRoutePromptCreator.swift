import Foundation

struct NewNavigationRoutePromptCreator: PromptCreator {
    let newView: NavigationLink.ViewSpecification
    let chatHistoryId: String
    func prompt() -> String {
        """
        add a new Router.Route enum case called \(newView.routeName) \
        that is initialised with variables: \(newView.modelVariablesString). \
        Keep the solution simple, don't add any new files. IMPORTANT: implement the solution without asking any questions
        """
    }
}

extension NewNavigationRoutePromptCreator: PromptConfig {
    var filesToAdd: [String] { newView.filesNeededToCreateNavigationRoute }
    var chatHistoryID: String { chatHistoryId }
}

extension NavigationLink.ViewSpecification {
    
    var pathToViewOnceCreated: String {
        "\(viewFolderPath)\(viewName).swift"
    }
    
    var routeName: String {
        let modifiedName = viewName.replacingOccurrences(of: "View", with: "", options: .backwards)
        return modifiedName.prefix(1).lowercased() + modifiedName.dropFirst()
    }
    
    var filesNeededToCreateNavigationRoute: [String] {
        var models = models.map { $0.modelPath }
        models.append(pathToViewOnceCreated)
        models.append("Swot_It/SwotItApp/Navigation/Router.swift")
        return models
    }
    
    var modelVariablesString: String {
        let variables = models.map { "\($0.variableName) = \($0.modelType)" }
        return variables.joined(separator: " and ")
    }
}
