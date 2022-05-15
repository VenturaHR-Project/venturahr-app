import SwiftUI

struct VacancyView: View {
    @StateObject var viewModel: VacancyViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Form {
                        Section("Dados da vaga") {
                            VacancyEditTextField(text: $viewModel.vacancyRequest.ocupation,
                                                 title: "Ocupação",
                                                 placeholder: "Digite a ocupação")
                            
                            VacancyEditTextField(text: $viewModel.vacancyRequest.description,
                                                 title: "Descrição",
                                                 placeholder: "Digite a descrição")
                            
                            VacancyEditTextField(text: $viewModel.vacancyRequest.company,
                                                 title: "Empresa",
                                                 placeholder: "Empresa de teste")
                            
                            NavigationLink {
                                StateSelectorView(
                                    selectedState: $viewModel.vacancyRequest.state,
                                    states: viewModel.ibgeStates
                                ).onChange(of: viewModel.vacancyRequest.state) { newValue in
                                    viewModel.fetchCities()
                                }
                            } label: {
                                Text("UF")
                                Spacer()
                                Text(viewModel.vacancyRequest.state)
                            }
                            
                            NavigationLink {
                                CitySelectorView(
                                    selectedCity: $viewModel.vacancyRequest.city,
                                    cities: viewModel.ibgeCities
                                )
                            } label: {
                                Text("Cidade")
                                Spacer()
                                Text(viewModel.vacancyRequest.city)
                            }
                            
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.automatic)
                .navigationTitle(Text("Cadastrar Vagas"))
            }
        }
        .onAppear(perform: viewModel.fetchStates)
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
