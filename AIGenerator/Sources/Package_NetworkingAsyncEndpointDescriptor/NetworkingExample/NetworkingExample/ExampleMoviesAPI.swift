import Foundation

enum ExampleMoviesAPI: Endpoint {
    
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

extension ExampleMoviesAPI {
    struct ExamplePopularMoviesResponse: Decodable {
        let results: [MoviesResponse]
        struct MoviesResponse: Decodable {
            let title: String
            let id: Int
        }
    }
}
