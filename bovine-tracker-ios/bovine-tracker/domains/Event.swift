import Foundation

class Event: Codable, Identifiable {
    var id: Int
    var type: EventType
    var value: String
    var date: Date
    var bovineId: String

    init(id: Int = 0, type: EventType, value: String, date: Date = Date(), bovineId: String) {
        self.id = id
        self.type = type
        self.value = value
        self.date = date
        self.bovineId = bovineId
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
