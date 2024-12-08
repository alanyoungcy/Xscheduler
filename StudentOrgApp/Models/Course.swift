struct Course: Identifiable, Codable {
    let id: UUID
    var name: String
    var instructor: String
    var roomNumber: String
    var color: String // Store as hex string
    var schedule: [ClassSchedule]
    
    init(id: UUID = UUID(), name: String = "", instructor: String = "", roomNumber: String = "", color: String = "#FF0000", schedule: [ClassSchedule] = []) {
        self.id = id
        self.name = name
        self.instructor = instructor
        self.roomNumber = roomNumber
        self.color = color
        self.schedule = schedule
    }
}

struct ClassSchedule: Codable {
    var dayOfWeek: Int
    var startTime: Date
    var endTime: Date
    var chapter: String
    var chapterTitle: String
} 