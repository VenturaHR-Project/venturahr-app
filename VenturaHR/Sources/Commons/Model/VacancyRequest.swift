struct VacancyRequest {
    var uid: String = ""
    var ocupation: String = ""
    var description: String = ""
    var company: String = ""
    var state: String = ""
    var city: String = ""
    var jobType: JobType = .clt
    var hiringPeriod: HiringPeriod = .full
    var expectedSkills: [ExpectedSkill] = []
    var createdAt = ""
    var expiresAt = ""
}
