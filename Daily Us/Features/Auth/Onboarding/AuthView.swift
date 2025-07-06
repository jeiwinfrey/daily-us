import SwiftUI

struct AuthView: View {
    @State private var isPressed = false
    @State private var isSignInPressed = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 24) {

                // Device illustration placeholder
                DeviceIllustrationView()
                    .padding(.horizontal, 24)
                    .padding(.vertical, 6)
                
                // App icon and title section
                VStack(spacing: 24) {
                    HStack(spacing: 12) {
                        // App icon
                        Image("DailyUsIcon")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        // App name
                        Text("Daily Us")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                    }
                    
                    // Tagline
                    Text("Share quotes that matter\nwith friends who care")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.black.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black.opacity(0.7))
                        .lineSpacing(4)
                }
                
                // Action buttons
                VStack(spacing: 16) {
                    // Primary button
                    Text("Create an account")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(Color(red: 240/255, green: 152/255, blue: 177/255))
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                        .scaleEffect(isPressed ? 0.85 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: isPressed)
                        .onTapGesture {
                            // Create account action
                        }
                        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                            isPressed = pressing
                        }, perform: {})
                        .padding(.horizontal, 24)
                    
                    // Secondary button
                    Text("Sign in")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.black.opacity(0.6))
                        .scaleEffect(isSignInPressed ? 0.85 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: isSignInPressed)
                        .onTapGesture {
                            // Sign in action
                        }
                        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                            isSignInPressed = pressing
                        }, perform: {})
                }
                .padding(.bottom, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

struct DeviceIllustrationView: View {
    var body: some View {
        ZStack {
            // Device frame
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.gray.opacity(0.1))
                .stroke(Color.gray.opacity(0.3), lineWidth: 3)
            
            // Dynamic Island
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 35)
                    .padding(.top, 20)
                
                Spacer()
            }
                
            // Home screen content
            VStack(spacing: 16) {
                // Rows 1-2: Large widget with pink stroke (2x4)
                HStack {
                    LargeWidgetView(hasStroke: true)
                        .frame(width: 308, height: 146)
                        .padding(.top, 30)
                }
                .frame(maxWidth: .infinity)
                
                // Row 3: 4 icons
                HStack(spacing: 16) {
                    AppIconView()
                    AppIconView()
                    AppIconView()
                    AppIconView()
                }
                .frame(maxWidth: .infinity)
                
                // Row 4: 2 icons
                HStack(spacing: 16) {
                    AppIconView()
                    AppIconView()
                    AppIconView()
                    AppIconView()
                }
                .frame(maxWidth: .infinity)
                
                // Row 5: blank
                HStack(spacing: 16) {
                    AppIconView()
                    AppIconView()
                    // Add invisible spacers to match 4-icon width
                    Color.clear.frame(width: 65, height: 65)
                    Color.clear.frame(width: 65, height: 65)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(width: 340)
            .padding(.top, 20)
        }
    }
}

struct LargeWidgetView: View {
    let hasStroke: Bool
    
    @State private var currentQuoteIndex = 0
    @State private var opacity: Double = 1.0
    
    private let quotes = [
        "Your friends \nare waiting.",
        "Start sharing inspiration.",
        "Join thousands of users.",
        "Make someone's day.",
        "Connect through quotes.",
        "Be the friend \nwho cares.",
        "Spread joy daily.",
        "Your words matter."
    ]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.gray.opacity(0.1))
            .stroke(hasStroke ? Color(red: 240/255, green: 152/255, blue: 177/255) : Color.clear, lineWidth: 3)
            .overlay(
                Text(quotes[currentQuoteIndex])
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .opacity(opacity)
                    .animation(.easeInOut(duration: 0.3), value: opacity)
            )
            .onAppear {
                startFadeAnimation()
            }
    }
    
    private func startFadeAnimation() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            // Fade out
            withAnimation(.easeInOut(duration: 0.3)) {
                opacity = 0.0
            }
            
            // Change quote and fade in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
                
                withAnimation(.easeInOut(duration: 0.3)) {
                    opacity = 1.0
                }
            }
        }
    }
}

struct AppIconView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 65, height: 65)
    }
}
            
#Preview {
    AuthView()
} 
