import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EventListView()
                .tabItem {
                    Label("Events list", systemImage:"list.bullet")
                }
            CreateEventView()
                .tabItem{
                    Label("CreateEvent", systemImage: "list.bullet")
                }
        }
    }
}
