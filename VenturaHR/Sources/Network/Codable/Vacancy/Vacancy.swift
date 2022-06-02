import Foundation

struct Vacancy {
    var id: String?
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
    var score: Double?
    var status: String?
    
    static func decode(data: Data) -> [Vacancy]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([Vacancy].self, from: data)
    }
}

extension Vacancy: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
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
        case score
        case status
    }
}
