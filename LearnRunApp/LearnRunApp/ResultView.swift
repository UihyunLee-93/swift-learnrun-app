import SwiftUI

struct QuizProgress {
    var correctAnswers: Int = 1
    var collectedItems: [String] = ["🍀"]
    var isCompleted: Bool {
        return collectedItems.count == 4
    }
}

struct ResultView: View {
    @State private var progress = QuizProgress()
    @State private var showStartView = false

    var body: some View {
        ZStack {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("수집에 성공하셨습니다")
                    .font(.title)
                    .bold()
                    .padding()

                Text("수집한 아이템: \(progress.collectedItems.joined(separator: " "))")
                    .font(.headline)
                    .padding()

                Button(action: {
                    showStartView.toggle()
                }) {
                    Text("다음단계로 이동")
                        .frame(width: 160, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 40)

                Spacer()
            }
        }
    }
}

#Preview {
    ResultView()
}
