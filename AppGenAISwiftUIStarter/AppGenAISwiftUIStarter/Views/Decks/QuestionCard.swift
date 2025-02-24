import SwiftUI

struct QuestionCard: View {
    @ObservedObject var question: Question
    
    // This is required to handle a bug with SwiftUI TextEditor becoming blank on 2nd showing
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
