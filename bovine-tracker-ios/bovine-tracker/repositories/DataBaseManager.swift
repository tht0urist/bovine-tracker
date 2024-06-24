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
        guard let database = database else { return [] }
        var events = [Event]()

        do {
            let query = QueryBuilder
                .select(SelectResult.all())
                .from(DataSource.collection(try database.defaultCollection()))

            let resultSet = try query.execute()
            let decoder = JSONDecoder()
            
            for result in resultSet.allResults() {
                if let dict = result.dictionary(forKey: "_default"),
                   let data = try? JSONSerialization.data(withJSONObject: dict.toDictionary(), options: []),
                   let event = try? decoder.decode(Event.self, from: data) {
                    events.append(event)
                }
            }
        } catch {
            print("Error fetching events: \(error.localizedDescription)")
        }
        return events
    }
}
