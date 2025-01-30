import Foundation

extension EnvironmentRouterNavigation.NavigationLink {
    static func savedDecksToDeckDetailNavigationSpec() -> EnvironmentRouterNavigation.NavigationLink {
        .init(
            from: .init(mvvmView: .savedDecksViewFeatureSpec()),
            to: .init(mvvmView: .deckDetailViewSpecification()),
            triggerDescriptionWhen: "a deck is selected from the list of decks",
            dataMappings: [.init(use: "savedDecks items in collection", toCreate: "deck")],
            routesPath: "\(AiderControl.Constants.appModuleRoot)Navigation/Router.swift",
            viewBuilderPath: "\(AiderControl.Constants.appModuleRoot)Navigation/SwiftUIRouteViewBuilder.swift"
        )
    }
}

extension EnvironmentRouterNavigation.NavigationLink.ViewSpecification {
    init(mvvmView: MVVM.ViewSpecification) {
        self.init(
            viewName: mvvmView.viewName,
            viewFolderPath: mvvmView.viewFolderPath,
            models: mvvmView.models.map { .init(mvvmViewData: $0) }
        )
    }
}

extension EnvironmentRouterNavigation.NavigationLink.ViewSpecification.ViewData {
    init(mvvmViewData: MVVM.ViewSpecification.ViewData) {
        self.init(
            variableName: mvvmViewData.variableName,
            modelType: mvvmViewData.modelType,
            modelPath: mvvmViewData.modelPath,
            isCollection: mvvmViewData.isCollection
        )
    }
}
