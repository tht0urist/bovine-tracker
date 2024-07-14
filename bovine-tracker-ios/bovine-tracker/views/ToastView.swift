import SwiftUI

struct ToastView: View {
    let message : String
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(10)
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
