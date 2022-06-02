struct VacancyViewData: Identifiable {
    var id: String = ""
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
    
    static func map(vacancies: [Vacancy]) -> [VacancyViewData] {
        let mappedVacancies: [VacancyViewData] = vacancies.map { vacancy in
            guard
                let id = vacancy.id,
                let jobType = JobType(rawValue: vacancy.jobType),
                let hiringPeriod = HiringPeriod(rawValue: vacancy.hiringPeriod)
            else { return VacancyViewData() }
            
            let expectedSkills = ExpectedSkill.map(expectedSkills: vacancy.expectedSkills)
            
            return VacancyViewData(id: id,
                                   uid: vacancy.uid,
                                   ocupation: vacancy.ocupation,
                                   description: vacancy.description,
                                   company: vacancy.company,
                                   state: vacancy.state,
                                   city: vacancy.city,
                                   jobType: jobType,
                                   hiringPeriod: hiringPeriod,
                                   expectedSkills: expectedSkills,
                                   createdAt: vacancy.createdAt,
                                   expiresAt: vacancy.expiresAt)
        }
        return mappedVacancies
    }
}
