//
//  Daily_UsApp.swift
//  Daily Us
//
//  Created by Jeiwinfrey Ulep on 7/6/25.
//

import SwiftUI

@main
struct Daily_UsApp: App {
    @StateObject private var splashViewModel = SplashViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if splashViewModel.isShowingSplash {
                    SplashView()
                        .environmentObject(splashViewModel)
                        .transition(.opacity)
                } else {
                    MainView()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.5), value: splashViewModel.isShowingSplash)
        }
    }
}
