import SwiftUI

struct EventDetailView: View {
    let event: Event
    var body: some View {
        Form {
            Section(header: Text("Détail de l'observation pour la bovine " + event.bovineId)) {
                LabeledContent("Type", value : event.type.description)
                LabeledContent("Valeur", value: event.value + ((event.type == EventType.WEIGHT) ? " Kg" : ""))
                LabeledContent("Date de l'observation", value: event.date.formatted())
            }
        }.navigationTitle("Observation pour la bovine " + event.bovineId)
    }
}
