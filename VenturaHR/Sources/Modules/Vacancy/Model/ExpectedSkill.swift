import Foundation

struct ExpectedSkill: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var description: String = ""
    var desiredMinimumProfile: DesiredMinimumProfile = .veryLow
    var height: Int = 1
    
    static func map(expectedSkills: [Skill]) -> [ExpectedSkill] {
        let skills: [ExpectedSkill] = expectedSkills.map { skill in
            let profile: DesiredMinimumProfile = DesiredMinimumProfile.convertValueToEnum(value: skill.desiredMinimumProfile)
            
            return ExpectedSkill(id: skill.id,
                                 description: skill.description,
                                 desiredMinimumProfile: profile,
                                 height: skill.height)
        }
        
        return skills
    }
}
