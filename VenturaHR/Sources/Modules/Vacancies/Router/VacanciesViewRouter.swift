import SwiftUI
import Combine

struct VacanciesViewRouter {
    static func start() -> some View  {
        let viewModel = VacanciesViewModel()
        return VacanciesView(viewModel: viewModel)
    }
    
    static func makeVacancyCreateView() -> some View {
        let viewModel = VacancyCreateViewModel()
        return VacancyCreateView(viewModel: viewModel)
    }
}
