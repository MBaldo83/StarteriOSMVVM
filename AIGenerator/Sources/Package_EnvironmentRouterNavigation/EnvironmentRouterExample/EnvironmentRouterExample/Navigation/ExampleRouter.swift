import Foundation
import SwiftUI

@MainActor
@Observable
public class ExampleRouter {
    
    var routePath: [ExampleRoute] = []
    var routeViewBuilder: ExampleSwiftUIRouteViewBuilder
    
    init(routeViewBuilder: ExampleSwiftUIRouteViewBuilder) {
        self.routeViewBuilder = routeViewBuilder
    }
    
    func view(for route: ExampleRoute) -> some View {
        routeViewBuilder.view(for: route)
    }
    
    func navigateTo(_ appRoute: ExampleRoute) {
        routePath.append(appRoute)
    }
}
