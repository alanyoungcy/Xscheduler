import SwiftUI

struct SubjectCard: View {
    let subject: Course
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(subject.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    // Show options menu
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            
            if let nextClass = subject.schedule.first {
                Text("Chapter \(nextClass.chapter)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: subject.color))
        )
        .frame(height: 100)
    }
} 