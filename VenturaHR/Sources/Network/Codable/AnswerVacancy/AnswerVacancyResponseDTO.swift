import Foundation

struct AnswerVacancyResponseDTO: Codable {
    var userUid: String
    var vacancyId: String
    var userName: String
    var userPhone: String
    var score: Double
    
    static func decode(data: Data) -> [AnswerVacancyResponseDTO]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([AnswerVacancyResponseDTO].self, from: data)
    }
}
