import Foundation

struct NewNavigationViewBuilderPromptCreator: PromptCreator {
    
    let navigationLink: EnvironmentRouterNavigation.NavigationLink
    var newView: EnvironmentRouterNavigation.NavigationLink.ViewSpecification { navigationLink.to }
    let chatHistoryId: String
    private let exampleRouteViewBuilderClassName = "ExampleSwiftUIRouteViewBuilder"
    
    func prompt() -> String {
        """
        Using \(exampleRouteViewBuilderClassName) as an example, in the class \(navigationLink.viewBuilder.name), \ 
        using a switch over the provided route parameter add a new case \
        returning \(newView.viewName) initialised with variables: \(newView.modelVariablesString). \
        Don't wrap \(newView.viewName) in AnyView \
        IMPORTANT: implement the solution without asking any questions
        """
    }
}

extension NewNavigationViewBuilderPromptCreator: PromptConfig {
    var filesToAdd: [String] {
        newView.filesNeededToCreateNavigationViewBuilder +
        navigationLink.filesNeededToCreateViewBuilder +
        ["\(EnvironmentRouterNavigation.Constants.exampleNavigationRoot)Navigation/\(exampleRouteViewBuilderClassName).swift"]
    }
    var chatHistoryID: String { chatHistoryId }
}

extension EnvironmentRouterNavigation.NavigationLink {
    var filesNeededToCreateViewBuilder: [String] {
        [viewBuilder.filePath]
    }
}

extension EnvironmentRouterNavigation.NavigationLink.ViewSpecification {
    var filesNeededToCreateNavigationViewBuilder: [String] {
        filesNeededToCreateNavigationRoute
    }
}
