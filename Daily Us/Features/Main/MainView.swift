import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(spacing: 30) {
            // Header
            VStack(spacing: 16) {
                Text("Daily Us")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Share inspiration daily")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            
            // Content area
            VStack(spacing: 20) {
                Image(systemName: "cloud.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color(red: 0.94, green: 0.60, blue: 0.69))
                
                Text("Welcome to Daily Us!")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text("Your app for sharing inspirational quotes with friends through home screen widgets.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16)
            
            // Coming soon section
            VStack(spacing: 12) {
                Text("Coming Soon")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 8) {
                    Label("Widget Creation", systemImage: "rectangle.stack.badge.plus")
                    Label("Friend Management", systemImage: "person.2")
                    Label("Quote Sharing", systemImage: "quote.bubble")
                    Label("Push Notifications", systemImage: "bell")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MainView()
} 