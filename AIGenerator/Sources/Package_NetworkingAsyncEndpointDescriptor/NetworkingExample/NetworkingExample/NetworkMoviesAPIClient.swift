import Foundation

class NetworkMoviesAPIClient {
    let networking: DecodingEndpointAsyncNetwork
    
    init(networking: DecodingEndpointAsyncNetwork) {
        self.networking = networking
    }
}

extension NetworkMoviesAPIClient: ExampleMoviesAPIClient {
    func getPopularMovies() async -> Result<[ExampleMovie], Error> {
        await networking.send(
            ExampleMoviesAPI.getPopularMovies,
            decodeTo: ExampleMoviesAPI.ExamplePopularMoviesResponse.self
        ).map(
            successMap: { response in
                response.results.map { ExampleMovie(title: $0.title, id: $0.id) }
            },
            errorMap: { $0 }
        )
    }
}
