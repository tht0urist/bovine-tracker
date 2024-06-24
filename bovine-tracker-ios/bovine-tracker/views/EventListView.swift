import SwiftUI
import CouchbaseLiteSwift

struct EventListView: View {
    @State private var events: [Event] = []
        
        var body: some View {
            NavigationView {
                    List(self.events) { event in
                        NavigationLink(destination: EventDetailView(event: event)) {
                            VStack(alignment: .leading) {
                                Text("Id de la bovine: \(event.bovineId)")
                                    .font(.headline)
                                Text("\(event.type.description): \(event.value)\(event.type == .WEIGHT ? " Kg" : "")")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .navigationTitle("Liste des événements")
                    .onAppear {
                        fetchEvents()
                    }
                }
        }
        
        private func fetchEvents() {
            self.events = DatabaseManager.shared.fetchEvents()
            print(self.events)
        }
}
