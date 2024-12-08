struct DashboardView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Subjects Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Subjects")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Recommendations for you")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(userViewModel.currentUser?.courses ?? []) { course in
                                    SubjectCard(subject: course)
                                        .frame(width: 160)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Schedule Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Your Schedule")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("Next lessons")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            ForEach(getTodaySchedule()) { course in
                                ScheduleCard(course: course,
                                           startTime: course.schedule[0].startTime,
                                           endTime: course.schedule[0].endTime)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("app_logo") // Add your app logo
                        .resizable()
                        .scaledToFit()
                        .frame(height: 32)
                }
            }
        }
    }
    
    private func getTodaySchedule() -> [Course] {
        // Implementation to get today's courses
        return userViewModel.currentUser?.courses ?? []
    }
} 