import SwiftUI

struct RouterView<Content: View>: View {
    
    @State var router: Router
    @State var modalRouter: ModalRouter
    // Our root view content
    private let content: Content
    
    init(router: Router,
         modalRouter: ModalRouter,
         @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.router = router
        self.modalRouter = modalRouter
    }
    
    var body: some View {
        NavigationStack(path: $router.routePath) {
            content
                .navigationDestination(for: Router.Route.self) { route in
                    router.view(for: route)
                }
                .sheet(isPresented: $modalRouter.isPresented) {
                    if let sheetRoute = modalRouter.currentSheet {
                        SheetContainerView(
                            close: {
                                modalRouter.dismiss()
                            }, content: {
                                router.view(for: sheetRoute)
                            }
                        )
                    }
                }
        }
        .environment(router)
        .environment(modalRouter)
    }
}

struct SheetContainerView<Content: View>: View {
    private let content: Content
    private let close: () -> Void
    init(
        close: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content()
        self.close = close
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button ("close") {
                    close()
                }
            }
            content
        }
        .padding()
    }
}
