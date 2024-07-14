import SwiftUI
import CouchbaseLiteSwift

struct EventListView: View {
    @State private var events: [Event] = []
    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List(filteredEvents) { event in
                    NavigationLink(destination: EventDetailView(event: event)) {
                        VStack(alignment: .leading) {
                            Text("Id du bovin: \(event.bovineId)")
                                .font(.headline)
                            Text("\(event.type.description): \(event.value)\(event.type == .WEIGHT ? " Kg" : "")")
                                .font(.subheadline)
                        }
                    }
                }
                .listStyle(PlainListStyle()) // Optional: For better styling
            }
            .navigationTitle("Liste des événements")
            .onAppear {
                fetchEvents()
            }
        }
    }
    
    private var filteredEvents: [Event] {
        if searchText.isEmpty {
            return events
        } else {
            let lowercasedSearchText = searchText.lowercased()
            return events.filter { $0.bovineId.lowercased().contains(lowercasedSearchText) }
        }
    }
    
    private func fetchEvents() {
        self.events = DatabaseManager.shared.fetchEvents()
    }
}
