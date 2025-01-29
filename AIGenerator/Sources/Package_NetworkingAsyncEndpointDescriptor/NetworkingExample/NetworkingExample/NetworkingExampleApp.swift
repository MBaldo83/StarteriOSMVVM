import SwiftUI

@main
struct NetworkingExampleApp: App {
    
    var networkingStack: DecodingEndpointAsyncNetwork = {
        RequestBuilderDecodingAsyncNetwork(
            requestBuilder: RequestBuilder(
                baseURLProvider: MoviesBaseURLProvider.production
            ),
            networkLayer: JSONDecodingAsyncNetwork(
                wrapping: URLSessionAsyncNetworkLayer()
            )
        )
    }()
    
    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: HomeView.ViewModel(
                    moviesClient: NetworkMoviesAPIClient(
                        networking: networkingStack
                    )
                )
            )
        }
    }
    
    enum MoviesBaseURLProvider: BaseURLProvider {
        case production
        func baseURL() -> URL? {
            switch self {
            case .production:
                return URL(string: "https://api.themoviedb.org/3/")
            }
        }
    }
}
