import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Search Bar
                    SearchBar(text: $searchText)
                        .padding(.horizontal)
                        .accessibilityIdentifier("searchBar")
                    
                    // Subjects Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Subjects",
                                    subtitle: "Recommendations for you")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(userViewModel.currentUser?.courses ?? []) { course in
                                    SubjectCardView(subject: course, icon: getIcon(for: course.name))
                                        .accessibilityIdentifier("subjectCard_\(course.name)")
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Schedule Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "Your Schedule",
                                    subtitle: "Next lessons")
                        
                        VStack(spacing: 16) {
                            ForEach(getTodaySchedule()) { course in
                                ScheduleItemView(
                                    course: course,
                                    startTime: course.schedule[0].startTime,
                                    endTime: course.schedule[0].endTime
                                )
                                .accessibilityIdentifier("scheduleItem_\(course.name)")
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
        }
    }
    
    private func getIcon(for subject: String) -> String {
        switch subject.lowercased() {
        case let name where name.contains("math"): return "function"
        case let name where name.contains("bio"): return "leaf.fill"
        case let name where name.contains("geo"): return "globe.americas.fill"
        default: return "book.fill"
        }
    }
    
    @MainActor
    private func getTodaySchedule() -> [Course] {
        return userViewModel.currentUser?.courses ?? []
    }
}

struct SectionHeader: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search", text: $text)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    HomeView()
        .environmentObject(PreviewData.sampleViewModel)
} 