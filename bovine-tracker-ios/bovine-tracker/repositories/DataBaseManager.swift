import CouchbaseLiteSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    var database: Database?

    private init() {
        do {
            let config = DatabaseConfiguration()
            database = try Database(name: "bovine-tracker-db", config: config)
        } catch {
            fatalError("Error opening database: \(error.localizedDescription)")
        }
    }

    func saveEvent(event: Event) {
        guard let database = database else { return }

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(event)
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                let mutableDoc = MutableDocument(data: jsonObject)
                try database.defaultCollection().save(document: mutableDoc)
            }
        } catch {
            print("Error saving event: \(error.localizedDescription)")
        }
    }

    func fetchEvents() -> [Event] {
        guard let database = self.database else { return [] }
        var events: [Event] = []

        do {
            let query = QueryBuilder
                .select(SelectResult.expression(Meta.id))
                .from(DataSource.collection(try database.defaultCollection()))
            
            let result = try query.execute()
            for row in result.allResults() {
                if let documentID = row.string(forKey: "id") {
                    if let document = try database.defaultCollection().document(id: documentID) {
                        let mutableDocument = document.toMutable()
                        if let event = Event(id: mutableDocument.id, dictionary: mutableDocument.toDictionary()) {
                            events.append(event)
                        } else {
                            print("Failed to convert document with ID \(documentID) to Event")
                        }
                    }
                }
            }
        } catch {
            print("Error executing query: \(error.localizedDescription)")
        }

        return events
    }
    
    func deleteEvent(event: Event) {
        guard let database = database else { return }
        do {
            if let eventId = event.id, let document = try database.defaultCollection().document(id: eventId) {
                try database.defaultCollection().delete(document: document)
                print("Event with ID \(eventId) deleted successfully.")
            } else {
                print("Document with ID \(event.id ?? "unknown") not found.")
            }
        } catch {
            print("Error deleting event: \(error.localizedDescription)")
        }
    }
}
