import SwiftUI

struct CafeProductDetailView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        CafeProductDetailContentView(
            name: $viewModel.product.name,
            description: $viewModel.product.description,
            isSubmitEnabled: viewModel.isSubmitEnabled,
            onSubmit: viewModel.submitChanges
        )
    }
}

struct CafeProductDetailContentView: View {
    @Binding var name: String
    @Binding var description: String
    let isSubmitEnabled: () -> Bool
    let onSubmit: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Submit Changes") {
                onSubmit()
            }
            .disabled(!isSubmitEnabled())
        }
        .padding()
    }
}
