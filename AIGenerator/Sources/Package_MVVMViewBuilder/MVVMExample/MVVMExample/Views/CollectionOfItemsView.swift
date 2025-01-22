import SwiftUI

struct CollectionOfItemsView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Button("View Action 1") {
                viewModel.viewActionOne()
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

extension CollectionOfItemsView {
    
    @Observable
    class ViewModel {
        
        var itemsCollection: [SingleItem]
        
        init(itemsCollection: [SingleItem]) {
            self.itemsCollection = itemsCollection
        }
        
        func viewActionOne() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let currentTime = dateFormatter.string(from: Date())
            itemsCollection.append(.mock(title: currentTime))
        }
    }
}
