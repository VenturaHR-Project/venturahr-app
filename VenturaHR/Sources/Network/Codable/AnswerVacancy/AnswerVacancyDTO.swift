import Foundation

struct AnswerVacancyDTO: Codable {
    var userUid: String
    var vacancyId: String
    var score: Double
    var createdDate: String
}
