import SwiftUI

struct DeckDetailsView: View {
    
    @ObservedObject var deck: Deck
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        DeckDetailsContentView(
            deck: deck,
            saveChanges: {
                try? viewContext.save()
            }
        )
    }
}

// This can be used in Previews
struct DeckDetailsContentView: View {
    
    @ObservedObject var deck: Deck
    let saveChanges: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Deck Info Section
            VStack(alignment: .leading, spacing: 8) {
                
                TextField("Deck Name", text: deck.nameBinding)
                .font(.title)
                .fontWeight(.bold)
                
                TextField("Deck Description", text: deck.deckDescriptionBinding)
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            // Questions List
            ScrollView {
                VStack(spacing: 12) {
                    
                    ForEach(deck.questionsForDetailsView) { question in
                        QuestionCard(
                            question: question
                        )
                    }
                }
                .padding(.horizontal)
            }
            
            // Bottom button
            Spacer()
            Button(action: saveChanges) {
                HStack {
                    Image(systemName: "square.and.arrow.down")
                    Text("Save")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}
