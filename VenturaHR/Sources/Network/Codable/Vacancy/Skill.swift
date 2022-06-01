struct Skill {
    var id: String
    var description: String
    var desiredMinimumProfile: Int
    var height: Int
    
    static func map(expectedSkills: [ExpectedSkill]) -> [Skill] {
        let skills: [Skill] = expectedSkills.map { skill in
            return Skill(id: skill.id,
                         description: skill.description,
                         desiredMinimumProfile: skill.desiredMinimumProfile.value,
                         height: skill.height)
        }
        
        return skills
    }
}

extension Skill: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case description
        case desiredMinimumProfile
        case height
    }
}
