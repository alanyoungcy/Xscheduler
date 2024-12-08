struct ScheduleCard: View {
    let course: Course
    let startTime: Date
    let endTime: Date
    
    var body: some View {
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
                Text("Chapter \(nextClass.chapter)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            HStack(spacing: 16) {
                Label {
                    Text(course.roomNumber)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.gray)
                }
                
                Label {
                    Text(course.instructor)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: course.color).opacity(0.1))
        )
    }
} 