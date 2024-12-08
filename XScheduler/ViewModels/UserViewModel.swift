import SwiftUI
import Foundation
import Combine

@MainActor
class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isOnboarding = true
    
    // Onboarding form fields
    @Published var name = ""
    @Published var institution = ""
    @Published var gradeLevel = ""
    @Published var email = ""
    @Published var selectedCourses: Set<UUID> = []
    
    var availableCourses: [Course] = [
        Course(name: "Mathematics", 
              instructor: "Brooklyn Williamson",
              roomNumber: "Room 6-205",
              color: "#4CAF50",
              chapter: "Chapter 1",
              chapterTitle: "Introduction"),
        Course(name: "Biology",
              instructor: "Julie Watson",
              roomNumber: "Room 2-168",
              color: "#2196F3",
              chapter: "Chapter 3",
              chapterTitle: "Animal Kingdom"),
        Course(name: "Geography",
              instructor: "Jenny Alexander",
              roomNumber: "Room 1-403",
              color: "#9C27B0",
              chapter: "Chapter 2",
              chapterTitle: "Economy USA")
    ]
    
    func completeOnboarding() {
        let selectedCoursesList = availableCourses.filter { selectedCourses.contains($0.id) }
        
        let newUser = User(
            name: name,
            institution: institution,
            gradeLevel: gradeLevel,
            email: email,
            courses: selectedCoursesList
        )
        
        self.currentUser = newUser
        self.isOnboarding = false
        saveUser()
    }
    
    private func saveUser() {
        // TODO: Implement persistence
    }
    
    func getTodaySchedule() -> [Course] {
        guard let user = currentUser else { return [] }
        
        let calendar = Calendar.current
        let today = calendar.component(.weekday, from: Date()) - 1
        
        return user.courses.filter { course in
            course.schedule.contains { schedule in
                schedule.dayOfWeek == today
            }
        }.sorted { course1, course2 in
            guard let time1 = course1.schedule.first?.startTime,
                  let time2 = course2.schedule.first?.startTime else {
                return false
            }
            return time1 < time2
        }
    }
} 