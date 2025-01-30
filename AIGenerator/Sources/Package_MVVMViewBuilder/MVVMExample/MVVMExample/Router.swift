import Foundation

@MainActor
@Observable
public class Router {
    var routePath: [ExampleRoute] = []
    
    func navigateTo(_ appRoute: ExampleRoute) {
        routePath.append(appRoute)
    }
}
