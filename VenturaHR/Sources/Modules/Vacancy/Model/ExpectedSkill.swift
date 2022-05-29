import Foundation

struct ExpectedSkill: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var description: String = ""
    var desiredMinimumProfile: DesiredMinimumProfile = .veryLow
    var height: Int = 1
}
