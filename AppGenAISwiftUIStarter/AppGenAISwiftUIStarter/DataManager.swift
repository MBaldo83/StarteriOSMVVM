import Foundation
import CoreData
import OrderedCollections

enum DataManagerType {
    case normal, preview, testing
}

class DataManager: NSObject, ObservableObject {
    static let shared = DataManager(type: .normal)
    static let preview = DataManager(type: .preview)
    static let testing = DataManager(type: .testing)
    
    @Published var decks: OrderedDictionary<UUID, LocalDeck> = [:]
    
    var localDecksArray: [LocalDeck] {
        Array(decks.values)
    }
    
    fileprivate var managedObjectContext: NSManagedObjectContext
    private let decksFRC: NSFetchedResultsController<DeckMO>
    
    private init(type: DataManagerType) {
        
        switch type {
        case .normal:
            let persistentStore = PersistentStore()
            self.managedObjectContext = persistentStore.context
        case .preview:
            let persistentStore = PersistentStore(inMemory: true)
            self.managedObjectContext = persistentStore.context
            for i in 0..<10 {
                let newDeck = DeckMO(context: managedObjectContext)
                newDeck.name = "Deck \(i)"
            }
            try? self.managedObjectContext.save()
        case .testing:
            let persistentStore = PersistentStore(inMemory: true)
            self.managedObjectContext = persistentStore.context
        }
        
        let decksFR: NSFetchRequest<DeckMO> = DeckMO.fetchRequest()
        decksFR.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        decksFRC = NSFetchedResultsController(
            fetchRequest: decksFR,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        super.init()
        decksFRC.delegate = self
        try? decksFRC.performFetch()
        if let fetchedDecks = decksFRC.fetchedObjects {
            self.decks = OrderedDictionary(
                uniqueKeysWithValues: fetchedDecks.compactMap {
                    return ($0.id, LocalDeck(deckMO: $0))
                }
            )
        }
    }
}



extension DataManager {
    func delete(deck: LocalDeck) {
        // Fetch the corresponding DeckMO object from Core Data
        let predicate = NSPredicate(format: "id == %@", deck.id as CVarArg)
        let result = fetchFirst(DeckMO.self, predicate: predicate)
        
        switch result {
        case .success(let managedObject):
            if let deckMO = managedObject {
                managedObjectContext.delete(deckMO)
            }
        case .failure(_):
            print("Couldn't fetch TodoMO to save")
        }
        saveData()
    }
    
    private func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        do {
            let result = try managedObjectContext.fetch(request) as? [T]
            return .success(result?.first)
        } catch {
            return .failure(error)
        }
    }
}

extension DataManager {
    func saveNewDeck(name: String, description: String, questions: [Question]) {
        // Create the deck using NSEntityDescription
        guard let entity = NSEntityDescription.entity(forEntityName: "Deck", in: managedObjectContext) else {
            print("Failed to get entity description")
            return
        }
        let newDeck = DeckMO(entity: entity, insertInto: managedObjectContext)
        
        newDeck.id = UUID()
        newDeck.name = name
        newDeck.deckDescription = description
        
        // Create QuestionMOs for each question
        let questionMOs = questions.map { question in
            let questionEntity = NSEntityDescription.entity(forEntityName: "Question", in: managedObjectContext)!
            let questionMO = QuestionMO(entity: questionEntity, insertInto: managedObjectContext)
            questionMO.id = question.id
            questionMO.question = question.question
            questionMO.answer = question.answer
            questionMO.deck = newDeck
            return questionMO
        }
        
        newDeck.questions = NSOrderedSet(array: questionMOs)
        
        saveData()
    }

    func saveData() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
}

extension DataManager: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchedDecks = controller.fetchedObjects as? [DeckMO] {
            self.decks = OrderedDictionary(
                uniqueKeysWithValues: fetchedDecks.compactMap {
                    return ($0.id, LocalDeck(deckMO: $0))
                }
            )
        }
    }
}

//MARK: - Todo Methods
extension LocalDeck {
    fileprivate init(deckMO: DeckMO) {
        self.id = deckMO.id
        self.name = deckMO.name
        self.deckDescription = deckMO.deckDescription
        
        // Safely cast the questions array
        if let questions = deckMO.questions.array as? [QuestionMO] {
            self.questions = questions.map { questionMO in
                Question(questionMO: questionMO)
            }
        } else {
            self.questions = []
        }
    }
}

extension Question {
    fileprivate init(questionMO: QuestionMO) {
        self.id = questionMO.id
        self.question = questionMO.question
        self.answer = questionMO.answer
    }
}

class DeckMO: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var deckDescription: String
    @NSManaged var id: UUID
    @NSManaged var questions: NSOrderedSet
    
    @nonobjc public class func  fetchRequest() -> NSFetchRequest<DeckMO> {
        return NSFetchRequest<DeckMO>(entityName: "Deck")
    }
}

class QuestionMO: NSManagedObject {
    @NSManaged var answer: String
    @NSManaged var question: String!
    @NSManaged var id: UUID
    @NSManaged var deck: DeckMO
}
