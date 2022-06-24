import SwiftUI

struct VacanciesViewRouter {
    static func start() -> some View  {
        let viewModel = VacanciesViewModel()
        return VacanciesView(viewModel: viewModel)
    }
    
    static func makeVacancyCreateView() -> some View {
        let viewModel = VacancyCreateViewModel()
        return VacancyCreateView(viewModel: viewModel)
    }
    
    static func makeAnswerVacancyView(userUid: String, vacancyId: String, expectedSkills: [ExpectedSkill]) -> some View {
        return AnswerVacancyView(userUid: userUid, vacancyId: vacancyId, expectedSkills: expectedSkills)
    }
    
    static func makeRankingView(vacancyId: String) -> some View {
        RankingViewRouter.start(vacancyId: vacancyId)
    }
}
