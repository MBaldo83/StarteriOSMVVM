import SwiftUI
import CoreData

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

extension Deck {
    var questionsForDetailsView: [Question] {
        let set = self.questions as? Set<Question> ?? []
        let sortedQuestions = set.sorted { $0.question ?? "" < $1.question ?? "" }
        return sortedQuestions
    }
}

extension Deck {
    
    var nameBinding: Binding<String> {
        Binding(
            get: { self.nameCoalesced },
            set: { self.name = $0 }
        )
    }
    
    var deckDescriptionBinding: Binding<String> {
        Binding(
            get: { self.deckDescriptionCoalesced },
            set: { self.deckDescription = $0 }
        )
    }
    
    var nameCoalesced: String {
        name ?? ""
    }
    
    var deckDescriptionCoalesced: String {
        deckDescription ?? ""
    }
}

extension Deck {
    func delete(
        in context: NSManagedObjectContext
    ) {
        context.delete(self)
        do {
            try context.save()
        } catch {
            print("Failed to delete deck: \(error)")
        }
    }
}
