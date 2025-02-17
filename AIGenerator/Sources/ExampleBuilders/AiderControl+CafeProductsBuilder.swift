import Foundation

extension AiderControl {
    
    func runCafeProductsViewBuilder() {
        let viewBuilder = NewViewBuilder(newView: .cafeProductsListViewSpec())
        promptPipelineRunner.inference(
            using: viewBuilder,
            with: viewBuilder
        )
    }
    
    func runCafeProductsDetailsViewBuidler() {
        let viewBuilder = NewViewBuilder(newView: .cafeProductsDetailsViewSpec())
        promptPipelineRunner.inference(
            using: viewBuilder,
            with: viewBuilder
        )
    }
    
    func runCafeProductsToDetailsNavigationBuilder() {
        
        let navigationSpec = EnvironmentRouterNavigation.NavigationLink.cafeProductsToDetailsNavigationSpec()
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
