import SwiftUI

struct QuizProgress {
    var correctAnswers: Int = 1
    var collectedItems: [String] = ["🍀"]
    var isCompleted: Bool {
        return collectedItems.count == 4
    }
}

struct ResultView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showStartView = false
    @State private var rewardEmoji: String? = nil
    @State private var hasRewarded = false 

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()

                VStack {
                    Text("수집에 성공하셨습니다")
                        .font(.title)
                        .bold()
                        .padding()
                    // 보상으로 추가된 이모지 표시
                    if let reward = rewardEmoji {
                        Text("🎁 보상 이모지: \(reward)")
                            .font(.largeTitle)
                            .padding()
                    }

                    NavigationLink(destination: StartView().navigationBarBackButtonHidden(true), isActive: $showStartView) {
                        EmptyView()
                    }

                    Button(action: {
                        showStartView = true
                    }) {
                        Text("메뉴로 이동")
                            .frame(width: 160, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 40)

                    Spacer()
                }
                .onAppear {
                    if !hasRewarded {
                        if let newEmoji = userViewModel.addRandomEmoji() {
                            rewardEmoji = newEmoji
                            hasRewarded = true
                        }
                        print("🎁 지급된 최종 보상 이모지: \(rewardEmoji ?? "없음")")
                    }
                }
            }
        }
    }
}
