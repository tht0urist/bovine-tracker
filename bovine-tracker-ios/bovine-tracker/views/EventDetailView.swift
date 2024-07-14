import SwiftUI

struct EventDetailView: View {
    let event: Event
    
    var body: some View {
        Form {
            Section(header: Text("Détail de l'observation pour la bovine " + event.bovineId)) {
                LabeledContent("Type", value: event.type.description)
                LabeledContent("Valeur", value: event.value + ((event.type == EventType.WEIGHT) ? " Kg" : ""))
                LabeledContent("Date de l'observation", value: event.date.formatted())
            }
            Section {
                            Button(action: {
                                deleteEvent()
                            }) {
                                Text("Supprimer l'observation")
                                    .foregroundColor(.red)
                            }
                        }
        }
        .navigationTitle("Observation pour la bovine " + event.bovineId)
    }
    
    private func deleteEvent() {
        DatabaseManager.shared.deleteEvent(event: event)
    }
}
