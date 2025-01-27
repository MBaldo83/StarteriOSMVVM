import SwiftUI

class RelaxTabViewFactory {
    
    @MainActor
    @ViewBuilder
    func make() -> some View {
        RelaxingCircleView()
            .tabItem {
                Image(systemName: "circle")
                Text("Relax")
            }
    }
}

struct RelaxingCircleView: View {
    @State private var animateOne = false
    @State private var animateTwo = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [.blue, .cyan]),
                        center: .center,
                        startRadius: animateOne ? 0 : 100,
                        endRadius: animateTwo ? 50 : 250)
                )
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                        animateOne.toggle()
                    }
                    withAnimation(Animation.easeInOut(duration: 7).repeatForever(autoreverses: true)) {
                        animateTwo.toggle()
                    }
                }
        }
    }
}
