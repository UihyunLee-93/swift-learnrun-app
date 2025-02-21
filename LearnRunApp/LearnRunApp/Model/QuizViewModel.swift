import SwiftUI

struct Quiz: Identifiable, Codable {
   
    
        var id: UUID = UUID()
        var category: String
        var type: String
        var question: String
        var options: [String]?
        var answer: String
        var isCorrect: Bool = false
    

    private enum CodingKeys: String, CodingKey {
        case category, type, question, options, answer //
    }
}


class QuizViewModel: ObservableObject {
    @Published var quizzes: [Quiz] = []
    @Published var currentQuiz: Quiz?
    @Published var answeredCount: Int = 0
    private var allQuizzes: [Quiz] = []
    private var usedIndexes: Set<Int> = []
    @Published var quizBatchSize = 5
    @Published var selectedCategory: String = "swift"

    init() {
        loadQuizzes()
    }

    func loadQuizzes() {
        if let url = Bundle.main.url(forResource: "QuizData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedQuizzes = try decoder.decode([Quiz].self, from: data)

                print(" 전체 문제 개수: \(decodedQuizzes.count)")
                
              
                self.allQuizzes = decodedQuizzes.filter { $0.category == selectedCategory }.shuffled()

                print(" 선택된 카테고리(\(selectedCategory)) 문제 개수: \(allQuizzes.count)")
                
                if allQuizzes.count < quizBatchSize {
                    print(" 출제 가능한 문제가 부족합니다! 있는 문제로 채웁니다.")
                    self.quizzes = allQuizzes
                } else {
                    self.quizzes = Array(allQuizzes.prefix(quizBatchSize))
                }

                
                while quizzes.count < quizBatchSize, let extraQuiz = allQuizzes.randomElement() {
                    if !quizzes.contains(where: { $0.id == extraQuiz.id }) {
                        quizzes.append(extraQuiz)
                    }
                }

                print(" 실제 출제 문제 개수: \(quizzes.count)")

                usedIndexes.removeAll()
                answeredCount = 0
                fetchNextQuiz()
            } catch {
                print(" JSON 로드 실패: \(error)")
            }
        } else {
            print(" JSON 파일을 찾을 수 없음")
        }
    }

    func fetchNextQuiz() {
        if answeredCount >= quizBatchSize {
            print(" 5문제를 모두 풀었습니다. 새로운 문제 세트를 로드합니다.")
            return
        }

        var availableIndexes = quizzes.indices.filter { !usedIndexes.contains($0) }
        print(" 출제 가능한 문제 인덱스: \(availableIndexes)")

        if availableIndexes.isEmpty {
            print(" 출제 가능한 문제가 없습니다! 새로운 문제를 로드합니다.")
            loadQuizzes()
            return
        }

        let randomIndex = availableIndexes.randomElement()!
        usedIndexes.insert(randomIndex)
        currentQuiz = quizzes[randomIndex]

        print(" 현재 문제: \(currentQuiz?.question ?? "문제 없음")")
    }

    func answerCurrentQuiz() {
        answeredCount += 1
        if answeredCount < quizBatchSize {
            fetchNextQuiz()
        } else {
            print(" 모든 문제를 풀었습니다.")
        }
    }

    func changeCategory(to newCategory: String) {
        if selectedCategory != newCategory {
            selectedCategory = newCategory
            print("카테고리를 \(newCategory)로 변경")
            loadQuizzes()
        }
    }
}
