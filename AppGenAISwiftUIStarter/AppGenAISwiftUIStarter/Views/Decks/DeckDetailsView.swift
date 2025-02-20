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
                
                TextField("Deck Name", text: Binding(
                    get: { deck.name ?? "" },
                    set: { deck.name = $0 }
                ))
                .font(.title)
                .fontWeight(.bold)
                
                TextField("Deck Description", text: Binding(
                    get: { deck.deckDescription ?? "" },
                    set: { deck.deckDescription = $0 }
                ))
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

struct QuestionCard: View {
    @ObservedObject var question: Question
    @State private var editableQuestion: String = ""
    @State private var editableAnswer: String = ""
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Question
            VStack(alignment: .leading) {
                Text("Q:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                TextEditor(text: $editableQuestion)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Answer
            VStack(alignment: .trailing) {
                Text("A:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                TextEditor(text: $editableAnswer)
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
        .onAppear {
            editableQuestion = question.question ?? ""
            editableAnswer = question.answer ?? ""
        }
        .onChange(of: editableQuestion) { old, new in
            question.question = editableQuestion
        }
        .onChange(of: editableAnswer) { old, new in
            question.answer = editableAnswer
        }
    }
}

extension Deck {
    var questionsForDetailsView: [Question] {
        let set = self.questions as? Set<Question> ?? []
        let sortedQuestions = set.sorted { $0.question ?? "" < $1.question ?? "" }
        return sortedQuestions
    }
}
