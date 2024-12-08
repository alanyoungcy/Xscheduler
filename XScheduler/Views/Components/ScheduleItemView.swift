import SwiftUI
import Foundation

struct ScheduleItemView: View {
    let course: Course
    let startTime: Date
    let endTime: Date
    
    init(course: Course, startTime: Date, endTime: Date) {
        self.course = course
        self.startTime = startTime
        self.endTime = endTime
    }
    
    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(timeFormatter.string(from: startTime))
                    .font(.headline)
                Text(timeFormatter.string(from: endTime))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(width: 70)
            
            Rectangle()
                .fill(Color(hex: course.color))
                .frame(width: 4)
                .cornerRadius(2)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(course.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        // Show options
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                    }
                }
                
                if let nextClass = course.schedule.first {
                    Text(nextClass.chapterTitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack(spacing: 16) {
                    Label(course.roomNumber, systemImage: "mappin.circle.fill")
                    Label(course.instructor, systemImage: "person.circle.fill")
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: course.color).opacity(0.1))
        )
    }
}

#Preview {
    ScheduleItemView(
        course: PreviewData.sampleCourse,
        startTime: Date(),
        endTime: Date().addingTimeInterval(3600)
    )
    .padding()
} 