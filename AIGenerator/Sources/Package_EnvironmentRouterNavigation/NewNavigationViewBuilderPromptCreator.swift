import Foundation

struct NewNavigationViewBuilderPromptCreator: PromptCreator {
    
    let navigationLink: EnvironmentRouterNavigation.NavigationLink
    var newView: EnvironmentRouterNavigation.NavigationLink.ViewSpecification { navigationLink.to }
    let chatHistoryId: String
    private let exampleRouteViewBuilderClassName = "ExampleSwiftUIRouteViewBuilder"
    
    func prompt() -> String {
        """
        Using \(exampleRouteViewBuilderClassName) as an example, In the class SwiftUIRouteViewBuilder, \ 
        return a new \(newView.viewName) initialised with variables: \(newView.modelVariablesString). \
        This is a first draft, keep the solution simple. IMPORTANT: implement the solution without asking any questions
        """
    }
}

extension NewNavigationViewBuilderPromptCreator: PromptConfig {
    var filesToAdd: [String] {
        newView.filesNeededToCreateNavigationViewBuilder +
        navigationLink.filesNeededToCreateViewBuilder +
        ["\(EnvironmentRouterNavigation.Constants.exampleNavigationRoot)\(exampleRouteViewBuilderClassName).swift"]
    }
    var chatHistoryID: String { chatHistoryId }
}

extension EnvironmentRouterNavigation.NavigationLink {
    var filesNeededToCreateViewBuilder: [String] {
        [viewBuilderPath]
    }
}

extension EnvironmentRouterNavigation.NavigationLink.ViewSpecification {
    var filesNeededToCreateNavigationViewBuilder: [String] {
        filesNeededToCreateNavigationRoute
    }
}
