import Foundation

struct Quiz: Identifiable, Codable {
    var id: UUID = UUID()
    var category: String
    var level: Int
    var type: String
    var question: String
    var options: [String]?  // 선택지 (객관식일경우에)
    var answer: String
    var isCorrect: Bool = false
}
