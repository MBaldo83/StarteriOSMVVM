import SwiftUI

struct SingleItem {
    let title: String
    let count: Int
}

struct SingleItemView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        SingleItemContentView(
            item: viewModel.item,
            viewActionOne: viewModel.viewActionOne
        )
    }
}

// This can be used in Previews
struct SingleItemContentView: View {
    
    let item: SingleItem
    let viewActionOne: () -> Void
    
    var body: some View {
        VStack {
            Button(
                "View Action 1",
                action: viewActionOne
            )
            Text("Title: \(item.title)")
            Text("Count: \(item.count)")
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
