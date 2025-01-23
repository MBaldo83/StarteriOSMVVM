import SwiftUI

struct CollectionOfItemsView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        CollectionOfItemsContentView(
            itemsCollection: viewModel.itemsCollection,
            viewActionOne: viewModel.viewActionOne
        )
    }
}

// This can be used in Previews
struct CollectionOfItemsContentView: View {
    
    let itemsCollection: [SingleItem]
    let viewActionOne: () -> Void
    
    var body: some View {
        VStack {
            Button(
                "View Action 1",
                action: viewActionOne
            )
            ForEach(0..<itemsCollection.count, id: \.self) { index in
                let item = itemsCollection[index]
                VStack {
                    Text("Title: \(item.title)")
                    Text("Count: \(itemsCollection.count)")
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
