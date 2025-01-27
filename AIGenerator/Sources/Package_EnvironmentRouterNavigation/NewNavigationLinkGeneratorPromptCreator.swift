import Foundation

struct NewNavigationLinkGeneratorPromptCreator: PromptCreator {
    let link: EnvironmentRouterNavigation.NavigationLink
    let chatHistoryId: String
    
    func prompt() -> String {
        """
        In \(link.from.viewName) when \(link.triggerDescriptionWhen), use the router Environment variable \
        to navigate to \(link.to.viewName). \
        \(link.modelVariablesFullMappingDescription) \
        This is a first draft, keep the solution simple. IMPORTANT: implement the solution without asking any questions
        """
    }
}

extension NewNavigationLinkGeneratorPromptCreator: PromptConfig {
    var filesToAdd: [String] {
        link.from.filesNeededNavigate +
        link.to.filesNeededNavigate +
        [link.routesPath]
    }
    var chatHistoryID: String { chatHistoryId }
}

extension EnvironmentRouterNavigation.NavigationLink {
    var modelVariablesFullMappingDescription: String {
        let variables = dataMappings.map { "use \($0.use) to create \($0.toCreate)" }
        return variables.joined(separator: " and ")
    }
}

extension EnvironmentRouterNavigation.NavigationLink.ViewSpecification {
    var filesNeededNavigate: [String] {
        models.map { $0.modelPath } +
        [pathToViewOnceCreated]
    }
}
