//
//  XSchedulerTests.swift
//  XSchedulerTests
//
//  Created by  Alan Young on 9/12/2024.
//

import XCTest
@testable import XScheduler

@MainActor
final class XSchedulerTests: XCTestCase {
    var userViewModel: UserViewModel!
    
    override func setUpWithError() throws {
        userViewModel = UserViewModel()
    }
    
    override func tearDownWithError() throws {
        userViewModel = nil
    }
    
    func testUserCreation() async throws {
        // Given
        let name = "John Doe"
        let institution = "Test University"
        let gradeLevel = "Senior"
        let email = "john@test.com"
        
        // When
        await MainActor.run {
            userViewModel.name = name
            userViewModel.institution = institution
            userViewModel.gradeLevel = gradeLevel
            userViewModel.email = email
            userViewModel.completeOnboarding()
        }
        
        // Then
        await MainActor.run {
            XCTAssertNotNil(userViewModel.currentUser)
            XCTAssertEqual(userViewModel.currentUser?.name, name)
            XCTAssertEqual(userViewModel.currentUser?.institution, institution)
            XCTAssertEqual(userViewModel.currentUser?.gradeLevel, gradeLevel)
            XCTAssertEqual(userViewModel.currentUser?.email, email)
        }
    }
    
    func testCourseSelection() async throws {
        // Given
        let course = await MainActor.run { userViewModel.availableCourses[0] }
        
        // When
        await MainActor.run {
            userViewModel.selectedCourses.insert(course.id)
            userViewModel.completeOnboarding()
        }
        
        // Then
        await MainActor.run {
            XCTAssertTrue(userViewModel.currentUser?.courses.contains(where: { $0.id == course.id }) ?? false)
        }
    }
    
    func testScheduleFiltering() async throws {
        // Given
        let calendar = Calendar.current
        let now = Date()
        let today = calendar.component(.weekday, from: now) - 1
        
        let course = Course(
            name: "Test Course",
            instructor: "Test Instructor",
            roomNumber: "101",
            schedule: [
                ClassSchedule(
                    dayOfWeek: today,
                    startTime: now,
                    endTime: calendar.date(byAdding: .hour, value: 1, to: now)!,
                    chapter: "1",
                    chapterTitle: "Introduction"
                )
            ]
        )
        
        // When
        await MainActor.run {
            userViewModel.selectedCourses.insert(course.id)
            userViewModel.completeOnboarding()
        }
        
        let todaySchedule = await MainActor.run {
            userViewModel.getTodaySchedule()
        }
        
        // Then
        XCTAssertTrue(todaySchedule.contains(where: { $0.id == course.id }))
    }
}
