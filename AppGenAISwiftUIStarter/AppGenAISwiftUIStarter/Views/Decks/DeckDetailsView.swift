import SwiftUI

struct DeckDetailsView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        DeckDetailsContentView(deck: viewModel.deck)
    }
}

// This can be used in Previews
struct DeckDetailsContentView: View {
    
    let deck: LocalDeck
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Deck Info Section
            VStack(alignment: .leading, spacing: 8) {
                Text(deck.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(deck.deckDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            // Questions List
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(deck.questions) { question in
                        QuestionCard(question: question)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct QuestionCard: View {
    let question: Question
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Question
            VStack(alignment: .leading) {
                Text("Q:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(question.question)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Answer
            VStack(alignment: .trailing) {
                Text("A:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(question.answer)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 5,
            x: 0,
            y: 2
        )
    }
}

extension DeckDetailsView {
    
    @Observable
    class ViewModel {
        
        var deck: LocalDeck
        
        init(deck: LocalDeck) {
            self.deck = deck
        }
    }
}
