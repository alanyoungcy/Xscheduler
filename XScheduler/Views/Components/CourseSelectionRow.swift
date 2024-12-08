import SwiftUI

struct CourseSelectionRow: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    let course: Course
    
    @MainActor
    private var isSelected: Bool {
        userViewModel.selectedCourses.contains(course.id)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                    .font(.headline)
                Text(course.instructor)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .accentColor : .gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .onTapGesture {
            Task { @MainActor in
                if isSelected {
                    userViewModel.selectedCourses.remove(course.id)
                } else {
                    userViewModel.selectedCourses.insert(course.id)
                }
            }
        }
    }
}

#Preview {
    CourseSelectionRow(course: PreviewData.sampleCourse)
        .environmentObject(PreviewData.sampleViewModel)
        .padding()
} 