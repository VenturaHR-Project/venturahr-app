import SwiftUI

struct VacancyView: View {
    @StateObject var viewModel: VacancyViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.uiState {
            case let .hasError(message):
                errorState(message: message)
            case .loading:
                ProgressView()
            case .emptyList:
                emptyState
            case .fullList:
                fullState
            }
        }
        .onAppear(perform: viewModel.handleOnAppear)
    }
    
    var emptyState: some View {
        Text("Hello word")
    }
    
    var fullState: some View {
        NavigationView {
            VStack {
                Text("Hello word")
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle(Text("Vagas"))
            .toolbar {
                Button(action: { }) {
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
    
    func errorState(message: String) -> some View {
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
