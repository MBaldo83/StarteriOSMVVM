import Foundation
import SwiftUI

@MainActor
@Observable
public class Router {
    
    var routePath: [Route] = []
    var routeViewBuilder: SwiftUIRouteViewBuilder
    
    init(routeViewBuilder: SwiftUIRouteViewBuilder) {
        self.routeViewBuilder = routeViewBuilder
    }
    
    func view(for route: Route) -> some View {
        routeViewBuilder.view(for: route)
    }
    
    func navigateTo(_ appRoute: Route) {
        routePath.append(appRoute)
    }
}
