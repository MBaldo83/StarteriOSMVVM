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
                            answer: $0.question,
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

extension DeckGeneratorView {
    func generateDeck(
        name: String,
        description: String
    ) -> Deck? {
        
        let questions = [
            Question.new(question: "Who wrote Romeo and Juliet?", answer: "William Shakespeare", context: context),
            Question.new(question: "What is the chemical symbol for gold?", answer: "Au", context: context),
            Question.new(question: "What planet is known as the Red Planet?", answer: "Mars", context: context),
            Question.new(question: "What is the largest mammal in the world?", answer: "Blue Whale", context: context)
        ]
        
        return Deck.create(name: name, description: description, questions: questions, in: context)
    }
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

extension Deck {
    static func create(
        name: String,
        description: String,
        questions: [Question],
        in context: NSManagedObjectContext
    ) -> Deck? {
        let deck = Deck(context: context)
        deck.name = name
        deck.deckDescription = description
        deck.questions = NSSet(array: questions)
        
        do {
            try context.save()
            return deck
        } catch {
            print("Failed to save new deck: \(error)")
            return nil
        }
    }
}

extension Question {
    static func new(
        question: String,
        answer: String,
        context: NSManagedObjectContext
    ) -> Question {
        let newQuestion = Question(context: context)
        newQuestion.question = question
        newQuestion.answer = answer
        return newQuestion
    }
}
