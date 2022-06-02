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
    var status: String = ""
    var createdAt = ""
    var expiresAt = ""
    
    static func map(vacancies: [Vacancy]) -> [VacancyViewData] {
        let mappedVacancies: [VacancyViewData] = vacancies.map { vacancy in
            guard
                let id = vacancy.id,
                let jobType = JobType(rawValue: vacancy.jobType),
                let hiringPeriod = HiringPeriod(rawValue: vacancy.hiringPeriod),
                let status = vacancy.status
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
                                   status: status,
                                   createdAt: vacancy.createdAt,
                                   expiresAt: vacancy.expiresAt)
        }
        return mappedVacancies
    }
}
 
extension VacancyViewData {
    static var vacancyViewDataMock: VacancyViewData {
        .init(id: "",
              uid: "",
              ocupation: "Desenvolvedor Mobile II",
              description: "Lorem ipsum metus ante sollicitudin quisque maecenas consequat primis.",
              company: "Infnet",
              state: "RJ",
              city: "Rio de Janeiro",
              jobType: .clt,
              hiringPeriod: .full,
              expectedSkills: [
                .init(id: "", description: "", desiredMinimumProfile: .veryLow, height: 1)
              ],
              createdAt: "02/05/2022",
              expiresAt: "03/06/2022")
    }
}
