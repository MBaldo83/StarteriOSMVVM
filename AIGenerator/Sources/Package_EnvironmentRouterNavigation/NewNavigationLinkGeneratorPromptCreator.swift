import Foundation

struct NewNavigationLinkGeneratorPromptCreator: PromptCreator {
    let link: NavigationLink
    let chatHistoryId: String
    func prompt() -> String {
        """
        In \(link.from.viewName) when \(link.triggerDescription), use the router Environment variable \
        to navigate to \(link.to.viewName). \
        \(link.modelVariablesFullMappingDescription) \
        This is a first draft, keep the solution simple. IMPORTANT: implement the solution without asking any questions
        """
    }
}

extension NewNavigationLinkGeneratorPromptCreator: PromptConfig {
    var filesToAdd: [String] {
        var filePaths = link.from.filesNeededNavigate
        filePaths.append(contentsOf: link.to.filesNeededNavigate)
        filePaths.append("Swot_It/SwotItApp/Navigation/Router.swift")
        return filePaths
    }
    var chatHistoryID: String { chatHistoryId }
}

extension NavigationLink {
    var modelVariablesFullMappingDescription: String {
        let variables = dataMappings.map { "use \($0.use) to create \($0.toCreate)" }
        return variables.joined(separator: " and ")
    }
}

extension NavigationLink.ViewSpecification {
    var filesNeededNavigate: [String] {
        var models = models.map { $0.modelPath }
        models.append(pathToViewOnceCreated)
        return models
    }
}
