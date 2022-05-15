struct VacancyRequest {
    var ocupation: String = ""
    var description: String = ""
    var company: String = ""
    var state: String = ""
    var city: String = ""
    var jobType: JobType = .clt
    var hiringPeriod: HiringPeriod = .full
    var expectedSkills: [ExpectedSkills] = []
}

enum JobType: String, CaseIterable {
    case clt = "CLT"
    case pj = "PJ"
}

enum HiringPeriod: String, CaseIterable {
    case half = "Meio período"
    case full = "Período integral"
}

struct ExpectedSkills {
    var description: String
    var desiredMinimumProfile: DesiredMinimumProfile
}

enum DesiredMinimumProfile: String {
    case veryLow = "Muito baixo"
    case short = "Baixo"
    case medium = "Médio"
    case hight = "Alto"
    case veryHight = "Muito alto"
    
    var value: Int {
        switch self {
        case .veryLow: return 1
        case .short: return 2
        case .medium: return 3
        case .hight: return 4
        case .veryHight: return 5
        }
    }
}
