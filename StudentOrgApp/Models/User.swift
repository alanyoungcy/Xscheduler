struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var institution: String
    var gradeLevel: String
    var email: String
    var courses: [Course]
    
    init(id: UUID = UUID(), name: String = "", institution: String = "", gradeLevel: String = "", email: String = "", courses: [Course] = []) {
        self.id = id
        self.name = name
        self.institution = institution
        self.gradeLevel = gradeLevel
        self.email = email
        self.courses = courses
    }
} 