import SwiftUI

struct SingleItemDataModifyingView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Button("Modifiy Item") {
                viewModel.modifyItem()
            }
            Text("Title: \(viewModel.item.title)")
            Text("Count: \(viewModel.item.count)")
        }
    }
}

extension SingleItemDataModifyingView {
    
    @Observable
    class ViewModel {
        
        var item: SingleItem
        
        init(item: SingleItem) {
            self.item = item
        }
        
        func modifyItem() {
            let shuffledTitle = String(item.title.shuffled())
            let newCount = item.count + 1
            item = .init(title: shuffledTitle, count: newCount)
        }
    }
}
