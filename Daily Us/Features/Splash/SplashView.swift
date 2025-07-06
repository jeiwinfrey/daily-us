import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var viewModel: SplashViewModel
    
    var body: some View {
        ZStack {
            // Pink background from SVG color
            Color(red: 0.94, green: 0.60, blue: 0.69) // #f098b1
                .ignoresSafeArea()
                .opacity(viewModel.backgroundOpacity)
            
            // White cloud icon
            Image(systemName: "cloud.fill")
                .font(.system(size: 80, weight: .light))
                .foregroundColor(.white)
                .scaleEffect(viewModel.iconScale)
                .opacity(viewModel.iconOpacity)
        }
        .onAppear {
            viewModel.startAnimation()
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(SplashViewModel())
} 