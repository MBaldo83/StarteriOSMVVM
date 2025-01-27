import Foundation
import SwiftUI

@MainActor
@Observable
public class ExampleRouter {
    
    var routePath: [Route] = []
    var routeViewBuilder: ExampleSwiftUIRouteViewBuilder
    
    init(routeViewBuilder: ExampleSwiftUIRouteViewBuilder) {
        self.routeViewBuilder = routeViewBuilder
    }
    
    func view(for route: Route) -> some View {
        routeViewBuilder.view(for: route)
    }
    
    func navigateTo(_ appRoute: Route) {
        routePath.append(appRoute)
    }
}
