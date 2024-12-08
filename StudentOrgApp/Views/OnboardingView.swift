import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var name = ""
    @State private var institution = ""
    @State private var gradeLevel = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Full Name", text: $name)
                    TextField("Institution", text: $institution)
                    TextField("Grade Level/Year", text: $gradeLevel)
                    TextField("Email", text: $email)
                }
                
                Section {
                    Button("Get Started") {
                        viewModel.createUser(
                            name: name,
                            institution: institution,
                            gradeLevel: gradeLevel,
                            email: email
                        )
                    }
                    .disabled(name.isEmpty || institution.isEmpty || gradeLevel.isEmpty || email.isEmpty)
                }
            }
            .navigationTitle("Welcome")
        }
    }
} 