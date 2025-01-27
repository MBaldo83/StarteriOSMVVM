import SwiftUI

struct HomeView: View {
    
    @Environment(ExampleRouter.self) private var router: ExampleRouter
    
    var body: some View {
        HomeContentView(
            navigateToViewOne: {
                router.navigateTo(.viewWithNoArguments)
            },
            navigateToViewTwo: { item in
                router.navigateTo(.viewWithModel(item: item))
            }
        )
    }
}

struct HomeContentView: View {
    
    let navigateToViewOne: () -> Void
    let navigateToViewTwo: (SingleItem) -> Void
    
    var body: some View {
        List {
            Button("View 1 (No Arguments)", action: navigateToViewOne)
            Button(
                "View 2 (Pass Data Model)",
                action: {
                    navigateToViewTwo(
                        .init(
                            title: "\(Date.now)",
                            count: 0
                        )
                    )
                }
            )
        }
        .navigationTitle("Home")
    }
}

#Preview {
    HomeContentView(
        navigateToViewOne: { },
        navigateToViewTwo: { _ in }
    )
}
