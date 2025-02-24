import SwiftUI
import CoreData

struct DeckGeneratorView: View {
    
    @State var questions = [QuestionViewState]()
    @State var name: String
    @State var deckDescription: String
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        DeckGeneratorContentView(
            questions: questions,
            generateDeck: {
                self.questions = [
                    QuestionViewState(question: "Who wrote Romeo and Juliet?", answer: "William Shakespeare"),
                    QuestionViewState(question: "What is the chemical symbol for gold?", answer: "Au"),
                    QuestionViewState(question: "What planet is known as the Red Planet?", answer: "Mars"),
                    QuestionViewState(question: "What is the largest mammal in the world?", answer: "Blue Whale")
                ]
            },
            saveDeck: {
                _ = Deck.create(
                    name: name,
                    description: deckDescription,
                    questions: self.questions.map{
                        Question.new(
                            question: $0.question,
                            answer: $0.answer,
                            context: context
                        )
                    },
                    in: context
                )
            },
            name: $name,
            deckDescription: $deckDescription
        )
    }
}

struct QuestionViewState: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct DeckGeneratorContentView: View {
    
    let questions: [QuestionViewState]
    let generateDeck: () -> Void
    let saveDeck: () -> Void
    @Binding var name: String
    @Binding var deckDescription: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Name and Description Fields
                TextField("Deck Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Deck Description", text: $deckDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Buttons
                HStack {
                    Button(action: generateDeck) {
                        Text("Generate")
                    }
                    Button(action: saveDeck) {
                        Text("Save")
                    }
                }
                
                ForEach(questions) { question in
                    VStack {
                        HStack {
                            Text(question.question)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text(question.answer)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding()
    }
}
