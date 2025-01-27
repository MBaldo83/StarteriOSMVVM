import Foundation

extension AiderControl {
    
    func runSavedDecksToDeckDetailNavigationBuilder() {
        
        let navigationSpec = EnvironmentRouterNavigation.NavigationLink.savedDecksToDeckDetailNavigationSpec()
        let chatHistoryId = currentTimeStampChatId()
        
        let newRoutePromptCreator = NewNavigationRoutePromptCreator(
            navigationLink: navigationSpec,
            chatHistoryId: chatHistoryId
        )
        
        let newUIBuilderPromptCreator = NewNavigationViewBuilderPromptCreator(
            navigationLink: navigationSpec,
            chatHistoryId: chatHistoryId
        )
        
        let navigationLinkBetweenViewsPromptCreator = NewNavigationLinkGeneratorPromptCreator(
            link: navigationSpec,
            chatHistoryId: chatHistoryId
        )
        
        let inferencingTuples: [(promptCreator: PromptCreator, promptConfig: PromptConfig)] = [
            (newRoutePromptCreator, newRoutePromptCreator),
            (newUIBuilderPromptCreator, newUIBuilderPromptCreator),
            (navigationLinkBetweenViewsPromptCreator, navigationLinkBetweenViewsPromptCreator)
        ]
        
        for tuple in inferencingTuples {
            promptPipelineRunner.inference(
                using: tuple.promptCreator,
                with: tuple.promptConfig
            )
        }
    }
}
