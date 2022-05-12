import SwiftUI

struct MainViewRouter {
    static func start() -> some View  {
        let viewModel = MainViewModel()
        return MainView(viewModel: viewModel)
    }
}
