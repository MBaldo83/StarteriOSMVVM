import SwiftUI

struct SingleItem {
    let title: String
    let count: Int
}

struct SingleItemView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Button("View Action 1") {
                viewModel.viewActionOne()
            }
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
        
        func viewActionOne() {
            let shuffledTitle = String(item.title.shuffled())
            let newCount = item.count + 1
            item = .init(title: shuffledTitle, count: newCount)
        }
    }
}
