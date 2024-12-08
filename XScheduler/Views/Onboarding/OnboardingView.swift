import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var currentStep = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TabView(selection: $currentStep) {
                    WelcomeView()
                        .tag(0)
                    
                    PersonalInfoView()
                        .tag(1)
                    
                    CourseSelectionView()
                        .tag(2)
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                Button(action: {
                    if currentStep < 2 {
                        withAnimation {
                            currentStep += 1
                        }
                    } else {
                        userViewModel.completeOnboarding()
                    }
                }) {
                    Text(currentStep < 2 ? "Continue" : "Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .accessibilityIdentifier("onboardingButton")
            }
            .navigationBarHidden(true)
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "graduationcap.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .foregroundColor(.accentColor)
            
            Text("Welcome to XScheduler")
                .font(.largeTitle)
                .fontWeight(.bold)
                .accessibilityIdentifier("welcomeTitle")
            
            Text("Organize your academic life with ease")
                .font(.title3)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

struct PersonalInfoView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Personal Information")
                .font(.largeTitle)
                .fontWeight(.bold)
                .accessibilityIdentifier("personalInfoTitle")
            
            VStack(spacing: 16) {
                TextField("Full Name", text: $userViewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("nameTextField")
                
                TextField("Institution", text: $userViewModel.institution)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("institutionTextField")
                
                TextField("Grade Level/Year", text: $userViewModel.gradeLevel)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("gradeLevelTextField")
                
                TextField("Email", text: $userViewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .accessibilityIdentifier("emailTextField")
            }
            
            Spacer()
        }
        .padding()
    }
}

struct CourseSelectionView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Select Your Courses")
                .font(.largeTitle)
                .fontWeight(.bold)
                .accessibilityIdentifier("courseSelectionTitle")
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(userViewModel.availableCourses) { course in
                        CourseSelectionRow(course: course)
                            .accessibilityIdentifier("courseRow_\(course.name)")
                    }
                }
            }
        }
        .padding()
    }
} 