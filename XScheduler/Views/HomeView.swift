import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    SearchBar(text: $searchText)
                        .padding(.horizontal)
                        .accessibilityIdentifier("searchBar")

                    SubjectsSection(courses: userViewModel.currentUser?.courses ?? [])

                    ScheduleSection(courses: getTodaySchedule())
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
        }
    }

    @MainActor
    private func getTodaySchedule() -> [Course] {
        return userViewModel.currentUser?.courses ?? []
    }
}

struct SubjectsSection: View {
    let courses: [Course]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Subjects",
                subtitle: "Recommendations for you"
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(courses) { course in
                        SubjectCardView(
                            subject: course,
                            icon: getIcon(for: course.name)
                        )
                        .accessibilityIdentifier("subjectCard_\(course.name)")
                    }
                }
                .padding(.horizontal)
            }
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
}

struct ScheduleSection: View {
    let courses: [Course]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(
                title: "Your Schedule",
                subtitle: "Next lessons"
            )

            VStack(spacing: 16) {
                ForEach(courses) { course in
                    if let firstSchedule = course.schedule.first {
                        ScheduleItemView(
                            course: course,
                            startTime: firstSchedule.startTime,
                            endTime: firstSchedule.endTime
                        )
                        .accessibilityIdentifier("scheduleItem_\(course.name)")
                    } else {
                        Text("No upcoming lessons")
                            .accessibilityIdentifier("noSchedule_\(course.name)")
                    }
                }
            }
            .padding(.horizontal)
        }
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
