import SwiftUI

struct VacancyView: View {
    @StateObject var viewModel: VacancyViewModel
    
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
        .onAppear(perform: viewModel.handleOnAppear)
    }
}

private extension VacancyView {
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
                        VacancyCardView(accountType: viewModel.accountType, viewData: vacancy)
                            .padding(.bottom)
                    }
                }.lineLimit(2)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(
                    id: "appIconToolbarItem",
                    placement: .principal,
                    showsByDefault: true
                ) {
                    Image(R.image.venturaOrageIcon.name)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 2)
                }
                ToolbarItem(
                    id: "addVacancyButtonToolbarItem",
                    placement: .navigationBarTrailing,
                    showsByDefault: viewModel.accountType.isCompany
                ) {
                    HStack {
                        NavigationLink(
                            isActive: $viewModel.shouldPresentVacancyCreateView,
                            destination: viewModel.goToVacancyCreateView
                        ) {
                            Button(action: viewModel.handleSelectAddVacancyButton) {
                                Text("Adicionar")
                                    .bold()
                                    .padding(5)
                                    .border(.orange)
                                    .font(.system(size: 16, weight: .bold))
                            }
                            .foregroundColor(.orange)
                        }
                    }
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

struct VacancyView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VacancyView(viewModel: VacancyViewModel())
                .preferredColorScheme($0)
        }
    }
}
