import SwiftUI
import Combine

struct VacancyViewRouter {
    static func start() -> some View  {
        let viewModel = VacancyViewModel()
        return VacancyView(viewModel: viewModel)
    }
    
    static func makeVacancyCreateView() -> some View {
        let viewModel = VacancyCreateViewModel()
        return VacancyCreateView(viewModel: viewModel)
    }
}
