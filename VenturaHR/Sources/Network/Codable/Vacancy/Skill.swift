struct Skill {
    var description: String
    var desiredMinimumProfile: Int
    var height: Int
    
    static func map(expectedSkills: [ExpectedSkill]) -> [Skill] {
        let skills: [Skill] = expectedSkills.map { skill in
            return Skill(description: skill.description,
                         desiredMinimumProfile: skill.desiredMinimumProfile.value,
                         height: skill.height)
        }
        
        return skills
    }
}

extension Skill: Codable {
    enum CodingKeys: String, CodingKey {
        case description
        case desiredMinimumProfile
        case height
    }
}
