import Foundation

class NetworkMoviesAPIClient {
    let networking: DecodingEndpointAsyncNetwork
    
    init(networking: DecodingEndpointAsyncNetwork) {
        self.networking = networking
    }
}

extension NetworkMoviesAPIClient: MoviesAPIClient {
    func getPopularMovies() async -> Result<[Movie], Error> {
        await networking.send(
            MoviesAPI.getPopularMovies,
            decodeTo: MoviesAPI.PopularMoviesResponse.self
        ).map(
            successMap: { response in
                response.movies.map { Movie(title: $0.title, id: $0.id) }
            },
            errorMap: { $0 }
        )
    }
}

extension MoviesAPI {
    struct PopularMoviesResponse: Decodable {
        let movies: [MoviesResponse]
        struct MoviesResponse: Decodable {
            let title: String
            let id: Int
        }
    }
}

enum MoviesAPI: Endpoint {
    
    case getPopularMovies
    
    var path: String {
        switch self {
        case .getPopularMovies:
            "movie/top_rated"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPopularMovies:
            .get
        }
    }
    
    var urlComponents: [String : String] {
        switch self {
        case .getPopularMovies:
            ["api_key":"e4f9e61f6ffd66639d33d3dde7e3159b"]
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .getPopularMovies:
            [:]
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getPopularMovies:
            return nil
        }
    }
}
