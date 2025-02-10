import Foundation

extension EnvironmentRouterNavigation.NavigationLink {
    static func cafeProductsToDetailsNavigationSpec() -> EnvironmentRouterNavigation.NavigationLink {
        .init(
            from: .init(
                // mapping from mvvm views to router navigation spec.
                // These 2 packages are de-coupled to allow flexibilty to choose other architectures
                mvvmView: .cafeProductsListViewSpec()
            ),
            to: .init(mvvmView: .cafeProductsDetailsViewSpec()),
            triggerDescriptionWhen: "a product Item is selected from the list of decks",
            dataMappings: [
                .init(use: "products in CafeProductsView collection", toCreate: "product")
            ],
            routes: .init(
                filePath: "\(AiderControl.Constants.appModuleRoot)Navigation/Route.swift",
                name: "Router.Routes"
            ),
            viewBuilder: .init(
                filePath: "\(AiderControl.Constants.appModuleRoot)Navigation/SwiftUIRouteViewBuilder.swift",
                name: "SwiftUIRouteViewBuilder"
            )
        )
    }
}
