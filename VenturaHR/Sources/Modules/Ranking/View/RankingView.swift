import SwiftUI

struct RankingView: View {
    @StateObject var viewModel: RankingViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.uiState {
            case let .error(message):
                errorStateView(message: message)
            case .loading:
                ProgressView()
            case .none:
                noneStateView
            case .success:
                fullStateView
            }
        }
        .onAppear(perform: viewModel.fetchCandidateRanking)
    }
}

private extension RankingView {
    var noneStateView: some View {
        Text("Ranking indisponível")
    }
    
    var fullStateView: some View {
        Text("Ranking indisponível")
    }
    
    func errorStateView(message: String) -> some View {
        Text("")
            .alert(isPresented: .constant(true)) {
                Alert(
                    title: Text("VenturaHR"), message: Text(message), dismissButton: .default(Text("Ok"))
                )
            }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RankingViewModel(vacancyId: "dsfsdfds")
        RankingView(viewModel: viewModel)
    }
}
