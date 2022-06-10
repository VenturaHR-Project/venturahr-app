import SwiftUI

struct VacanciesView: View {
    @StateObject var viewModel: VacanciesViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.uiState {
            case let .hasError(message):
                errorStateView(message: message)
            case .loading:
                ProgressView()
            case .emptyList:
                emptyStateView
            case .fullList:
                fullStateView
            }
        }
        .onAppear(perform: viewModel.fetchVacancies)
    }
}

private extension VacanciesView {
    var emptyStateView: some View {
        Text("Hello word")
    }
    
    var headerView: some View {
        VStack {
            Image(R.image.venturaOrageIcon.name)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 80)
            
            Divider()
        }
    }
    
    var fullStateView: some View {
        NavigationView {
            ScrollView {
                Divider()
                    .padding(.vertical, 10)
                
                LazyVStack {
                    Spacer()
                    
                    ForEach(viewModel.vacancies) { vacancy in
                        VacanciesCardView(accountType: viewModel.accountType, viewData: vacancy)
                            .padding(.bottom)
                    }
                }.lineLimit(2)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(
                    id: "appIconToolbarItem",
                    placement: .principal
                ) {
                    Image(R.image.venturaOrageIcon.name)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 2)
                }
            }
        }
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

struct VacanciesView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VacanciesView(viewModel: VacanciesViewModel())
                .preferredColorScheme($0)
        }
    }
}
