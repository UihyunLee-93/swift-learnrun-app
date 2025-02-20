//
//  QuizView.swift
//  LearnRunApp
//
//  Created by Uihyun.Lee on 2/20/25.
//


import SwiftUI

struct QuizView: View {
    @StateObject var viewModel = QuizViewModel()

    var body: some View {
        VStack {
            if let quiz = viewModel.currentQuiz { // 현재 문제 표시
                Text(quiz.question)
                    .font(.headline)
                
                if let options = quiz.options {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            checkAnswer(selected: option, for: quiz.id)
                        }) {
                            Text(option)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            } else {
                Text("🎉 모든 문제를 풀었습니다!") // ✅ 모든 문제를 풀면 메시지 표시
                    .font(.title)
                    .foregroundColor(.green)
            }
        }
    }

    // ✅ 정답 확인 및 저장
    func checkAnswer(selected: String, for quizID: UUID) {
        if let quiz = viewModel.currentQuiz, quiz.id == quizID {
            if selected == quiz.answer {
                viewModel.markAnswerCorrect(for: quizID) // ✅ 정답 체크 후 자동으로 새로운 문제 로드
            }
        }
    }
}
struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let previewViewModel = QuizViewModel()
        
        // 샘플 문제 강제 설정 (프리뷰에서만 사용)
        previewViewModel.currentQuiz = Quiz(
            id: UUID(),
            category: "Swift",
            level: 1,
            type: "Multiple Choice",
            question: "Swift에서 변수를 선언할 때 사용하는 키워드는?",
            options: ["var", "let", "const", "define"],
            answer: "var",
            isCorrect: false
        )

        return QuizView()
            .environmentObject(previewViewModel)
    }
}

