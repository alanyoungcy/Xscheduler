//
//  ContentView.swift
//  XScheduler
//
//  Created by  Alan Young on 9/12/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some View {
        if userViewModel.isOnboarding {
            OnboardingView()
                .environmentObject(userViewModel)
        } else {
            MainTabView()
                .environmentObject(userViewModel)
        }
    }
}

#Preview {
    ContentView()
}
