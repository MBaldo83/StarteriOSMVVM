import SwiftUI

struct CollectionOfItemsView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack {
            ForEach(0..<viewModel.itemsCollection.count, id: \.self) { index in
                let item = viewModel.itemsCollection[index]
                VStack {
                    Text("Title: \(item.title)")
                    Text("Count: \(viewModel.itemsCollection.count)")
                }
            }
        }
    }
}

extension CollectionOfItemsView {
    
    @Observable
    class ViewModel {
        
        var itemsCollection: [SingleItem]
        
        init(itemsCollection: [SingleItem]) {
            self.itemsCollection = itemsCollection
        }
    }
}
