//
//  QuizViewModel.swift
//  LearnRunApp
//
//  Created by Uihyun.Lee on 2/20/25.
//


import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var currentQuiz: Quiz? // 현재 문제
    private var allQuizzes: [Quiz] = [] // 전체 퀴즈 데이터
    private var remainingQuizzes: [Quiz] = [] // 남은 퀴즈 리스트
    

        init() {
            loadQuizzes()
            if currentQuiz == nil, !remainingQuizzes.isEmpty {
                fetchNextQuiz()
            }
        }
    

    // ✅ JSON에서 퀴즈 데이터 불러오기
    func loadQuizzes() {
        if let url = getFilePath(),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let decodedQuizzes = try? decoder.decode([Quiz].self, from: data) {
                self.allQuizzes = decodedQuizzes
                self.remainingQuizzes = decodedQuizzes.filter { !$0.isCorrect } // 맞춘 문제 제외
                fetchNextQuiz()
            }
        }
    }

    // ✅ **맞춘 문제 제외하고 한 문제씩 가져오기**
    func fetchNextQuiz() {
        if remainingQuizzes.isEmpty {
            currentQuiz = nil // 모든 문제를 풀었을 때
        } else {
            currentQuiz = remainingQuizzes.removeFirst() // 한 문제 가져오기
        }
    }

    // ✅ 정답을 맞춘 문제의 `isCorrect` 값을 `true`로 변경하고 JSON 저장
    func markAnswerCorrect(for quizID: UUID) {
        if let index = allQuizzes.firstIndex(where: { $0.id == quizID }) {
            allQuizzes[index].isCorrect = true
            saveQuizzes()
            fetchNextQuiz() // ✅ 정답 체크 후 새로운 문제 로드
        }
    }

    // ✅ 변경된 데이터를 JSON 파일로 저장
    func saveQuizzes() {
        if let url = getFilePath() {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            if let data = try? encoder.encode(allQuizzes) {
                try? data.write(to: url)
            }
        }
    }

    // ✅ JSON 파일 경로 가져오기 (앱 내 Document 폴더)
    private func getFilePath() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first?.appendingPathComponent("quizData.json")
    }
}
