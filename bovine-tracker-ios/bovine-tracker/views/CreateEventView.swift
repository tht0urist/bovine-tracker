import SwiftUI
import CouchbaseLiteSwift

struct CreateEventView: View {
    @State private var selectedType: EventType = .WEIGHT
    @State private var value: String = ""
    @State private var sheepId: String = ""
    
    @State private var showingToast = false
    @State private var isScanning = false
    @State private var scannedCode = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Form {
                    Picker("Type de l'observation", selection: $selectedType) {
                        ForEach(EventType.allCases) { type in
                            Text(type.description).tag(type)
                        }
                    }
                    
                    switch selectedType {
                    case .WEIGHT:
                        TextField("Poids", text: $value)
                            .keyboardType(.decimalPad)
                    case .VACCINATION:
                        TextField("Détails des vaccins", text: $value)
                    case .OTHER:
                        VStack(alignment: .leading) {
                            Text("Autres remarques")
                                .font(.headline)
                                .padding(.bottom, 2)
                            
                            TextEditor(text: $value)
                                .frame(height: 100)
                                .border(Color.gray, width: 1)
                                .padding(.bottom, 10)
                        }
                        .padding()
                    }
                    
                    HStack {
                        TextField("Numéro de la bovine", text: $sheepId)
                        Button("Scanner") {
                            isScanning = true
                        }
                    }
                    
                    Text("Date: \(Date(), style: .date)")
                        .foregroundColor(.secondary)
                    
                    Button("Sauvegarder") {
                        saveRecord()
                    }
                }
                .navigationTitle("Nouvelle observation")
                .sheet(isPresented: $isScanning) {
                    QRCodeScannerView(scannedCode: $scannedCode, isScanning: $isScanning)
                }
                .onChange(of: scannedCode) { newValue in
                    print(newValue)
                    if !newValue.isEmpty {
                        sheepId = newValue
                        scannedCode = "" // Clear the scanned code after using it
                    }
                }
                
                if showingToast {
                    ToastView(message: "Observation créée avec succès.")
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .zIndex(1)
                }
            }
            .animation(.spring(), value: showingToast)
        }
    }
    
    private func saveRecord() {
        let newEvent = Event(type: selectedType, value: value, bovineId: sheepId)
        DatabaseManager.shared.saveEvent(event: newEvent)
        value = ""
        scannedCode = ""
        sheepId = ""
        selectedType = .WEIGHT
        showToast()
    }
    
    private func showToast() {
        showingToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showingToast = false
        }
    }
}

