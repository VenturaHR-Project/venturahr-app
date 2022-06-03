import SwiftUI
import Combine

struct VacancyViewRouter {
    static func start() -> some View  {
        let viewModel = VacancyViewModel()
        return VacancyView(viewModel: viewModel)
    }
    
    static func makeVacancyCreateView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = VacancyCreateViewModel(publisher: publisher)
        return VacancyCreateView(viewModel: viewModel)
    }
}
