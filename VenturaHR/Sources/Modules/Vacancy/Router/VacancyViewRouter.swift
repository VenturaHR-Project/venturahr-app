import SwiftUI

struct VacancyViewRouter {
    static func start() -> some View  {
        let viewModel = VacancyViewModel()
        return VacancyView(viewModel: viewModel)
    }
}
