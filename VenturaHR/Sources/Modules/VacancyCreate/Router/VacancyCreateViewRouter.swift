import SwiftUI

struct VacancyCreateViewRouter {
    static func start() -> some View  {
        let viewModel = VacancyCreateViewModel()
        return VacancyCreateView(viewModel: viewModel)
    }
}
