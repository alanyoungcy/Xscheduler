import Foundation
import SwiftUI

@MainActor
struct PreviewData {
    static let sampleCourse = Course(
        name: "Mathematics",
        instructor: "Dr. Smith",
        roomNumber: "Room 101",
        color: "#4CAF50",
        schedule: [
            ClassSchedule(
                dayOfWeek: 1,
                startTime: Date(),
                endTime: Date().addingTimeInterval(3600),
                chapter: "Chapter 1",
                chapterTitle: "Introduction to Calculus"
            )
        ],
        chapter: "Chapter 1",
        chapterTitle: "Introduction to Calculus"
    )
    
    static let sampleUser = User(
        name: "John Doe",
        institution: "Sample University",
        gradeLevel: "Senior",
        email: "john@example.com",
        courses: [sampleCourse]
    )
    
    @MainActor
    static let sampleViewModel: UserViewModel = {
        let viewModel = UserViewModel()
        viewModel.currentUser = sampleUser
        viewModel.isOnboarding = false
        return viewModel
    }()
} 
