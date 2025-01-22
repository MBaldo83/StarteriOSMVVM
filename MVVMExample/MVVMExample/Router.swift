import Foundation

@MainActor
@Observable
public class Router {
    var routePath: [Route] = []
    
    func navigateTo(_ appRoute: Route) {
        routePath.append(appRoute)
    }
}
