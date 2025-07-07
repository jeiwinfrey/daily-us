import SwiftUI

struct MainView: View {
    @State private var friendCount = 1 // Will be dynamic later
    @State private var hasUnreadMessages = true // Will be dynamic later
    @State private var isProfilePressed = false
    @State private var isFriendsPressed = false
    @State private var isChatPressed = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                // Left - Profile icon
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.15))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.black.opacity(0.3))
                }
                .scaleEffect(isProfilePressed ? 0.85 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isProfilePressed)
                .onTapGesture {
                    // Profile action
                }
                .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                    isProfilePressed = pressing
                }, perform: {})
                
                Spacer()
                
                // Middle - Friends section (pill-shaped button)
                HStack(spacing: 8) {
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black.opacity(0.7))
                    
                    Text(friendsText)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.black.opacity(0.7))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 15)
                .background(Color.gray.opacity(0.15))
                .clipShape(Capsule())
                .scaleEffect(isFriendsPressed ? 0.85 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isFriendsPressed)
                .onTapGesture {
                    // Friends action
                }
                .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                    isFriendsPressed = pressing
                }, perform: {})
                
                Spacer()
                
                // Right - Chat icon
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.15))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "bubble.left.circle.fill")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.black.opacity(0.3))
                }
                .scaleEffect(isChatPressed ? 0.85 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isChatPressed)
                .onTapGesture {
                    // Chat action
                }
                .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                    isChatPressed = pressing
                }, perform: {})
            }
            .padding(.horizontal, 24)
            
            // Main content area
            Spacer()
            
            VStack(spacing: 24) {
                Text("Welcome to Daily Us")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Text("Start sharing inspirational quotes\nwith your friends")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.black.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .tint(Color(red: 240/255, green: 152/255, blue: 177/255))
    }
    
    private var friendsText: String {
        switch friendCount {
        case 0:
            return "Add Friends"
        case 1:
            return "1 Friend"
        default:
            return "\(friendCount) Friends"
        }
    }
}

#Preview {
    MainView()
} 
