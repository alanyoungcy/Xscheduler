import Foundation

enum AppError: LocalizedError {
    case invalidUserData
    case invalidCourseSelection
    case persistenceError
    
    var errorDescription: String? {
        switch self {
        case .invalidUserData:
            return "Please fill in all required fields"
        case .invalidCourseSelection:
            return "Please select at least one course"
        case .persistenceError:
            return "Failed to save user data"
        }
    }
} 