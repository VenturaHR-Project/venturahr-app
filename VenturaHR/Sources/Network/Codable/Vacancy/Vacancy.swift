import Foundation

struct Vacancy: Codable {
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
