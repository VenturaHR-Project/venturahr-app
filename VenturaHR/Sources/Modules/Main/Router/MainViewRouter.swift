import SwiftUI

struct MainViewRouter {
    static func start() -> some View  {
        let viewModel = MainViewModel()
        return MainView(viewModel: viewModel)
    }
    
    static func makeVacanciesView() -> some View {
        VacanciesViewRouter.start()
    }
    
    static func makeVacancyCreateView() -> some View {
        VacancyCreateViewRouter.start()
    }
}
