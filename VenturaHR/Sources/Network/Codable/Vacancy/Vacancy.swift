import Foundation

struct Vacancy {
    var uid: String
    var ocupation: String
    var description: String
    var company: String
    var state: String
    var city: String
    var jobType: String
    var hiringPeriod: String
    var expectedSkills: [Skill]
    var createdAt: String
    var expiresAt: String
}

extension Vacancy: Codable {
    enum CodingKeys: String, CodingKey {
        case uid
        case ocupation
        case description
        case company
        case state
        case city
        case jobType
        case hiringPeriod
        case expectedSkills
        case createdAt
        case expiresAt
    }
}
