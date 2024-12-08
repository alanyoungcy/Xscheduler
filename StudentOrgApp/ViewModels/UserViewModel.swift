@MainActor
class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isOnboarding = true
    
    func createUser(name: String, institution: String, gradeLevel: String, email: String) {
        let newUser = User(name: name, institution: institution, gradeLevel: gradeLevel, email: email)
        self.currentUser = newUser
        self.isOnboarding = false
        // TODO: Save to persistent storage
    }
} 