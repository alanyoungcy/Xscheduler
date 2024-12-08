import Foundation

struct Course: Identifiable, Codable {
    let id: UUID
    var name: String
    var instructor: String
    var roomNumber: String
    var color: String // Store as hex string
    var schedule: [ClassSchedule]
    var chapter: String
    var chapterTitle: String
    
    init(id: UUID = UUID(), 
         name: String = " Test ",
         instructor: String = "Test",
         roomNumber: String = "11",
         color: String = "#FF0000", 
         schedule: [ClassSchedule] = [],
         chapter: String = "",
         chapterTitle: String = "") {
        self.id = id
        self.name = name
        self.instructor = instructor
        self.roomNumber = roomNumber
        self.color = color
        self.schedule = schedule
        self.chapter = chapter
        self.chapterTitle = chapterTitle
    }
}

struct ClassSchedule: Codable {
    var dayOfWeek: Int
    var startTime: Date
    var endTime: Date
    var chapter: String
    var chapterTitle: String
    
    init(dayOfWeek: Int, 
         startTime: Date, 
         endTime: Date, 
         chapter: String = "",
         chapterTitle: String = "") {
        self.dayOfWeek = dayOfWeek
        self.startTime = startTime
        self.endTime = endTime
        self.chapter = chapter
        self.chapterTitle = chapterTitle
    }
} 
