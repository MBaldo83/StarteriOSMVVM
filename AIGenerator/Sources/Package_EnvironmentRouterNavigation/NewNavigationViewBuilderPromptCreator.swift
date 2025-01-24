import Foundation

struct NewNavigationViewBuilderPromptCreator: PromptCreator {
    let newView: NavigationLink.ViewSpecification
    let chatHistoryId: String
    func prompt() -> String {
        """
        In the class SwiftUIRouteViewBuilder, function view(for route: Router.Route) \
        implement the new switch case \(newView.routeName) returning a new \(newView.viewName) \
        initialised with variables: \(newView.modelVariablesString). \
        This is a first draft, keep the solution simple. IMPORTANT: implement the solution without asking any questions
        """
    }
}

extension NewNavigationViewBuilderPromptCreator: PromptConfig {
    var filesToAdd: [String] { newView.filesNeededToCreateNavigationViewBuilder }
    var chatHistoryID: String { chatHistoryId }
}

extension NavigationLink.ViewSpecification {
    var filesNeededToCreateNavigationViewBuilder: [String] {
        var models = filesNeededToCreateNavigationRoute
        models.append("Swot_It/SwotItApp/Navigation/SwiftUIRouteViewBuilder.swift")
        return models
    }
}
