import SwiftUI

struct DeckGeneratorView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        DeckGeneratorContentView(
            questions: viewModel.questions,
            generateDeck: viewModel.generateDeck,
            saveDeck: viewModel.saveDeck
        )
    }
}

struct DeckGeneratorContentView: View {
    let questions: [Question]
    let generateDeck: () -> Void
    let saveDeck: () -> Void

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: generateDeck) {
                        Text("Generate")
                    }
                    Button(action: saveDeck) {
                        Text("Save")
                    }
                    Spacer()
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


extension DeckGeneratorView {
    @Observable
    class ViewModel {
        var questions: [Question]
        
        init(questions: [Question]) {
            self.questions = questions
        }
        
        func saveDeck() {
            
        }
        
        func generateDeck() {
            questions = [
                Question(id: UUID(), question: "What is the capital of France?", answer: "Paris"),
                Question(id: UUID(), question: "Who wrote Romeo and Juliet?", answer: "William Shakespeare"),
                Question(id: UUID(), question: "What is the chemical symbol for gold?", answer: "Au"),
                Question(id: UUID(), question: "What planet is known as the Red Planet?", answer: "Mars"),
                Question(id: UUID(), question: "What is the largest mammal in the world?", answer: "Blue Whale")
            ]
        }
    }
}
