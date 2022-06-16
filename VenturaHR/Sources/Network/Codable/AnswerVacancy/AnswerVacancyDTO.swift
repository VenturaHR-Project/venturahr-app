import Foundation

struct AnswerVacancyDTO: Codable {
    var userUid: String
    var vacancyId: String
    var answers: [Answer]
    var createdDate: String
}
