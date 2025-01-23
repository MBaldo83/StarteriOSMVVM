import SwiftUI

struct DeckGeneratorView: View {
    
    @State var viewModel: ViewModel
    
    var body: some View {
        DeckGeneratorContentView(
            questions: viewModel.questions,
            viewActionOne: viewModel.viewActionOne
        )
    }
}

struct DeckGeneratorContentView: View {
    let questions: [Question]
    let viewActionOne: () -> Void

    var body: some View {
        VStack {
            Button(action: viewActionOne) {
                Text("View Action 1")
            }
            ForEach(questions) { question in
                Text(question.question)
            }
        }
    }
}


extension DeckGeneratorView {
    @Observable
    class ViewModel {
        var questions: [Question]
        
        init(questions: [Question]) {
            self.questions = questions
        }
        
        func viewActionOne() {
            // Placeholder for view action. Update as needed
            if let firstQuestion = questions.first {
                questions[0] = Question(question: firstQuestion.question + "!", answer: firstQuestion.answer)
            }
        }
    }
}
