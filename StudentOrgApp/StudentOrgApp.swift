@main
struct StudentOrgApp: App {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            if userViewModel.isOnboarding {
                OnboardingView()
                    .environmentObject(userViewModel)
            } else {
                MainTabView()
                    .environmentObject(userViewModel)
            }
        }
    }
} 