import SwiftUI

struct RankingViewRouter {
    static func start(vacancyId: String) -> some View  {
        let viewModel = RankingViewModel(vacancyId: vacancyId)
        return RankingView(viewModel: viewModel)
    }
}
