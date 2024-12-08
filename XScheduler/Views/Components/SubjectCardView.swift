import SwiftUI

struct SubjectCardView: View {
    let subject: Course
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer()
                
                Button(action: {
                    // Show options menu
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            
            Spacer()
            
            Text(subject.name)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: subject.color))
        )
        .frame(width: 160, height: 100)
    }
}

#Preview {
    SubjectCardView(subject: PreviewData.sampleCourse, icon: "function")
        .frame(width: 160)
        .padding()
} 