import SwiftUI

class NavigationStackViewFactory {
    
    @MainActor
    @ViewBuilder
    func make() -> some View {
        RouterView(
            router: Router(
                routeViewBuilder: SwiftUIRouteViewBuilder()
            )
        ) {
            SavedDecksView(
                viewModel: .init(
                    decks: [
                        .init(
                            id: UUID(),
                            name: "deck 1",
                            questions: [
                                .init(id: UUID(), question: "question 1", answer: "answer 1"),
                                .init(id: UUID(), question: "question 2", answer: "answer 2")
                            ]
                        ),
                        .init(
                            id: UUID(),
                            name: "deck 2",
                            questions: [
                                .init(id: UUID(), question: "question 1", answer: "answer 1"),
                                .init(id: UUID(), question: "question 2", answer: "answer 2")
                            ]
                        )
                    ]
                )
            )
        }
        .tabItem {
            Image(systemName: "map")
            Text("Stack")
        }
    }
}
