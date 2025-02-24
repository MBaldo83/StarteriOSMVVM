import Foundation
import CoreData

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
