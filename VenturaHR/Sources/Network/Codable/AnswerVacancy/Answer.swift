struct Answer: Codable {
    var description: String
    var answer: Int
    var height: Int
    
    static func map(expectedSkills: [ExpectedSkill]) -> [Answer] {
        let skills: [Answer] = expectedSkills.map { answer in
            return Answer(description: answer.description,
                          answer: answer.desiredMinimumProfile.value,
                          height: answer.height)
        }
        
        return skills
    }
}
