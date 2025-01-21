import SwiftUI

struct CollectionOfItemsDataModifyingView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Button("Add Item") {
                viewModel.addItem()
            }
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

extension CollectionOfItemsDataModifyingView {
    
    @Observable
    class ViewModel {
        
        var itemsCollection: [SingleItem]
        
        init(itemsCollection: [SingleItem]) {
            self.itemsCollection = itemsCollection
        }
        
        func addItem() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let currentTime = dateFormatter.string(from: Date())
            itemsCollection.append(.mock(title: currentTime))
        }
    }
}
