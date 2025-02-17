import SwiftUI

struct HomeView: View {
    
    @State var viewModel: ViewModel

    var body: some View {
        VStack {
            Button("Call API") {
                viewModel.callAPI()
            }
            .font(.largeTitle)
            
            if let error = viewModel.error {
                Text(error)
                    .font(.title3)
                    .foregroundStyle(.red)
            } else {
                ForEach(viewModel.movieTitles, id: \.self) { title in
                    Text(title)
                        .font(.title2)
                }
            }
        }
        .padding()
    }
}


protocol ExampleMoviesAPIClient {
    func getPopularMovies() async -> Result<[ExampleMovie], Error>
}

extension HomeView {
    
    @Observable
    class ViewModel {
        
        let moviesClient: ExampleMoviesAPIClient
        var movieTitles = [String]()
        var error: String?
        
        init(moviesClient: ExampleMoviesAPIClient) {
            self.moviesClient = moviesClient
        }
        
        func callAPI() {
            Task {
                let result = await moviesClient.getPopularMovies()
                switch result {
                case .success(let success):
                    error = nil
                    movieTitles = success.map { $0.title }
                case .failure(let failure):
                    error = failure.localizedDescription
                }
            }
        }
    }
}
