import Foundation
import SwiftUI

@MainActor
class SplashViewModel: ObservableObject {
    @Published var iconScale: CGFloat = 1.0
    @Published var iconOpacity: Double = 1.0
    @Published var backgroundOpacity: Double = 1.0
    @Published var isShowingSplash = true
    
    func startAnimation() {
        // Wait 1 second, then start growing animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.iconScale = 20.0 // Grow very large to fill screen
            }
            
            // Fade out pink background as icon grows
            withAnimation(.easeInOut(duration: 1.0).delay(0.5)) {
                self.backgroundOpacity = 0.0
            }
            
            // Fade out icon at the end
            withAnimation(.easeOut(duration: 0.5).delay(1.0)) {
                self.iconOpacity = 0.0
            }
        }
        
        // Transition to main content after animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.easeOut(duration: 0.3)) {
                self.isShowingSplash = false
            }
        }
    }
} 