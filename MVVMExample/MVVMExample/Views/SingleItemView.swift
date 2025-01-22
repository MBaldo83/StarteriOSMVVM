import SwiftUI

struct SingleItemView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Title: \(viewModel.item.title)")
            Text("Count: \(viewModel.item.count)")
        }
    }
}

extension SingleItemView {
    
    @Observable
    class ViewModel {
        
        var item: SingleItem
        
        init(item: SingleItem) {
            self.item = item
        }
    }
}

struct SingleItem {
    let title: String
    let count: Int
}
