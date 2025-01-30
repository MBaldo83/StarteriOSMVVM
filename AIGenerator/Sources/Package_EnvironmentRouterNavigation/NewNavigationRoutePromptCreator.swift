import Foundation

struct NewNavigationRoutePromptCreator: PromptCreator {
    let navigationLink: EnvironmentRouterNavigation.NavigationLink
    var newView: EnvironmentRouterNavigation.NavigationLink.ViewSpecification { navigationLink.to }
    let chatHistoryId: String
    private let exampleRouterClassName = "ExampleRouter"
    
    func prompt() -> String {
        """
        Using case \(newView.exampleCaseName) on ExampleRouter.ExampleRoute as an example, \ 
        add a new case on \(navigationLink.routes.name) called \(newView.routeName) \
        that is initialised with variables: \(newView.modelVariablesString). \
        Keep the solution simple, don't add any new files. IMPORTANT: implement the solution without asking any questions
        """
    }
}

extension NewNavigationRoutePromptCreator: PromptConfig {
    var filesToAdd: [String] {
        navigationLink.filesNeededToCreateNavigationRoute +
        newView.filesNeededToCreateNavigationRoute +
        ["\(EnvironmentRouterNavigation.Constants.exampleNavigationRoot)ExampleRoute.swift"]
    }
    var chatHistoryID: String { chatHistoryId }
}

extension EnvironmentRouterNavigation.NavigationLink {
    var filesNeededToCreateNavigationRoute: [String] {
        [routes.filePath]
    }
}

extension EnvironmentRouterNavigation.NavigationLink.ViewSpecification {
    
    var exampleCaseName: String {
        models.isEmpty ? "viewWithNoArguments" : "viewWithModel"
    }
    
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
        return models
    }
    
    var modelVariablesString: String {
        let variables = models.map { "\($0.variableName) = \($0.modelType)" }
        return variables.joined(separator: " and ")
    }
}

extension EnvironmentRouterNavigation {
    enum Constants {
        static let exampleNavigationRoot = "\(AiderControl.Constants.aiGeneratorRoot)Sources/Package_EnvironmentRouterNavigation/EnvironmentRouterExample/EnvironmentRouterExample/Navigation/"
        static let exampleRouteClassName = "ExampleRoute"
    }
}
