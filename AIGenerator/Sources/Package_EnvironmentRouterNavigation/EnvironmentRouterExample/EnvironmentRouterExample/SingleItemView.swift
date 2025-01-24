import SwiftUI

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

struct SingleItem: Equatable, Hashable {
    let title: String
    let count: Int
}

extension SingleItem {
    static func mock(
        title: String = "Mock Item",
        count: Int = 42
    ) -> SingleItem {
        SingleItem(title: title, count: count)
    }
}

extension SingleItemView {
    
    @Observable
    class ViewModel {
        
        var item: SingleItem
        var hostViewModel: SingleItemView.ViewModel?
        
        init(item: SingleItem,
             hostViewModel: SingleItemView.ViewModel? = nil) {
            self.item = item
            self.hostViewModel = hostViewModel
        }
        
        func viewActionOne() {
            let shuffledTitle = String(item.title.shuffled())
            let newCount = item.count + 1
            item = .init(title: shuffledTitle, count: newCount)
            hostViewModel?.item = item
        }
    }
}
