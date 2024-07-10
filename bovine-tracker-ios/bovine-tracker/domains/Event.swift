import Foundation

struct Event: Codable, Identifiable {
    var id: String?
    var type: EventType
    var value: String
    var date: Date
    var bovineId: String

    init(id: String? = nil, type: EventType, value: String, date: Date = Date(), bovineId: String) {
        self.id = id
        self.type = type
        self.value = value
        self.date = date
        self.bovineId = bovineId
    }

    init?(id: String, dictionary: [String: Any]) {
        guard let typeInt = dictionary["type"] as? Int,
              let value = dictionary["value"] as? String,
              let bovineId = dictionary["bovineId"] as? String,
              let type = EventType(rawValue: typeInt) else {
             // let dateString = dictionary["date"] as? String else {
             // let date = Event.dateFromUnixTimestamp(dateString) else {
            return nil
        }

        self.id = id
        self.type = type
        self.value = value
        self.date = Date()
        self.bovineId = bovineId
    }
    
    private static func dateFromUnixTimestamp(_ timestampString: String) -> Date? {
        if let timestamp = Double(timestampString) {
            return Date(timeIntervalSince1970: timestamp)
        }
        return nil
    }
}

enum EventType: Int, CaseIterable, Identifiable, Codable {
    case WEIGHT = 0
    case VACCINATION = 1
    case OTHER = 2

    var id: Int { self.rawValue }

    var description: String {
        switch self {
        case .WEIGHT:
            return "Poids"
        case .VACCINATION:
            return "Vaccination"
        case .OTHER:
            return "Autre observation"
        }
    }
}
