//
//  XSchedulerUITests.swift
//  XSchedulerUITests
//
//  Created by  Alan Young on 9/12/2024.
//

import XCTest

final class XSchedulerUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testOnboardingFlow() throws {
        // Test Welcome Screen
        let welcomeTitle = app.staticTexts["welcomeTitle"]
        XCTAssertTrue(welcomeTitle.exists)
        XCTAssertEqual(welcomeTitle.label, "Welcome to XScheduler")
        
        let onboardingButton = app.buttons["onboardingButton"]
        XCTAssertTrue(onboardingButton.exists)
        onboardingButton.tap()
        
        // Test Personal Info Screen
        let personalInfoTitle = app.staticTexts["personalInfoTitle"]
        XCTAssertTrue(personalInfoTitle.exists)
        XCTAssertEqual(personalInfoTitle.label, "Personal Information")
        
        let nameTextField = app.textFields["nameTextField"]
        XCTAssertTrue(nameTextField.exists)
        nameTextField.tap()
        nameTextField.typeText("John Doe")
        
        let institutionTextField = app.textFields["institutionTextField"]
        XCTAssertTrue(institutionTextField.exists)
        institutionTextField.tap()
        institutionTextField.typeText("Test University")
        
        let gradeLevelTextField = app.textFields["gradeLevelTextField"]
        XCTAssertTrue(gradeLevelTextField.exists)
        gradeLevelTextField.tap()
        gradeLevelTextField.typeText("Senior")
        
        let emailTextField = app.textFields["emailTextField"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("john@test.com")
        
        onboardingButton.tap()
        
        // Test Course Selection Screen
        let courseSelectionTitle = app.staticTexts["courseSelectionTitle"]
        XCTAssertTrue(courseSelectionTitle.exists)
        XCTAssertEqual(courseSelectionTitle.label, "Select Your Courses")
        
        // Select Mathematics course
        let mathCourseRow = app.buttons["courseRow_Mathematics"]
        XCTAssertTrue(mathCourseRow.exists)
        mathCourseRow.tap()
        
        onboardingButton.tap()
        
        // Verify we're on the home screen
        XCTAssertTrue(app.navigationBars["Home"].exists)
    }
    
    func testHomeScreenLayout() throws {
        // Complete onboarding first
        completeOnboarding()
        
        // Verify search bar exists
        let searchBar = app.otherElements["searchBar"]
        XCTAssertTrue(searchBar.exists)
        
        // Verify subject cards
        let mathCard = app.otherElements["subjectCard_Mathematics"]
        XCTAssertTrue(mathCard.exists)
        
        // Verify schedule items
        let mathSchedule = app.otherElements["scheduleItem_Mathematics"]
        XCTAssertTrue(mathSchedule.exists)
    }
    
    func testSearchFunctionality() throws {
        // Complete onboarding first
        completeOnboarding()
        
        // Test search
        let searchBar = app.textFields.matching(identifier: "searchBar").firstMatch
        XCTAssertTrue(searchBar.exists)
        
        searchBar.tap()
        searchBar.typeText("Math")
        
        // Verify filtered results
        let mathCard = app.otherElements["subjectCard_Mathematics"]
        XCTAssertTrue(mathCard.exists)
        
        let bioCard = app.otherElements["subjectCard_Biology"]
        XCTAssertFalse(bioCard.exists)
    }
    
    // Helper method to complete onboarding
    private func completeOnboarding() {
        // Welcome screen
        app.buttons["onboardingButton"].tap()
        
        // Personal info screen
        let nameTextField = app.textFields["nameTextField"]
        nameTextField.tap()
        nameTextField.typeText("John Doe")
        
        let institutionTextField = app.textFields["institutionTextField"]
        institutionTextField.tap()
        institutionTextField.typeText("Test University")
        
        let gradeLevelTextField = app.textFields["gradeLevelTextField"]
        gradeLevelTextField.tap()
        gradeLevelTextField.typeText("Senior")
        
        let emailTextField = app.textFields["emailTextField"]
        emailTextField.tap()
        emailTextField.typeText("john@test.com")
        
        app.buttons["onboardingButton"].tap()
        
        // Course selection screen
        app.buttons["courseRow_Mathematics"].tap()
        app.buttons["onboardingButton"].tap()
    }
}
