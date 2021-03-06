import SwiftUI
import PopupView

struct VacancyCreateView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: VacancyCreateViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Form {
                        dataSection
                        
                        skillSection
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text("Nova vaga"))
                .toolbar {
                    Button(action: viewModel.handleSaveVacancy) {
                        Text("Salvar")
                            .bold()
                            .padding(5)
                            .border(saveBarButtonColor)
                    }
                    .foregroundColor(saveBarButtonColor)
                    .disabled(viewModel.isSaveButtonDisabled)
                }
            }
            .popup(
                isPresented: $viewModel.shouldPresentPopup,
                type: .floater(verticalPadding: 0, useSafeAreaInset: true),
                position: .bottom,
                animation: .easeIn,
                autohideIn: 3,
                dragToDismiss: true,
                closeOnTap: true,
                closeOnTapOutside: true
            ) {
                ToastView(
                    imageName: R.image.checkmarkSeal.name,
                    message: "Vaga cadastrada com sucesso!",
                    isDisabled: .constant(false)
                )
            }
            
            if case UIState.error(let value) = viewModel.uiState {
                errorStateView(message: value)
            }
        }
        .onAppear(perform: viewModel.handleOnAppear)
    }
    
    var saveBarButtonColor: Color {
        viewModel.isSaveButtonDisabled ? .gray : .orange
    }
}

private extension VacancyCreateView {
    var dataSection: some View {
        Section {
            VacancyEditTextField(text: $viewModel.vacancy.ocupation,
                                 title: "Ocupa????o",
                                 placeholder: "Digite a ocupa????o")
            
            VacancyEditTextField(text: $viewModel.vacancy.description,
                                 title: "Descri????o",
                                 placeholder: "Digite a descri????o")
            
            VacancyEditTextField(text: $viewModel.vacancy.company,
                                 title: "Empresa",
                                 placeholder: "Empresa de teste")
            
            hiringPeriodField
            
            jobTypeField
            
            stateSelectorViewWithLink
            
            citySelectorViewWithLink
            
            DatePicker(
                "Data de cria????o",
                selection: $viewModel.createdDate,
                in: Date()...,
                displayedComponents: .date
            )
            .accentColor(.orange)
            
            DatePicker(
                "Data de expira????o",
                selection: $viewModel.expiresDate,
                in: viewModel.createdDate...viewModel.getNextMonth(),
                displayedComponents: .date
            )
            .accentColor(.orange)
        } header: {
            setSectionHeader(title: "Dados")
        }
    }
    
    var hiringPeriodField: some View {
        HStack {
            Text("Per??odo")
            
            Spacer()
            Picker("", selection: $viewModel.vacancy.hiringPeriod) {
                ForEach(HiringPeriod.allCases, id: \.self) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    var jobTypeField: some View {
        HStack {
            Text("Contrata????o")
            
            Spacer()
            Picker("", selection: $viewModel.vacancy.jobType) {
                ForEach(JobType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    var stateSelectorViewWithLink: some View {
        NavigationLink {
            StateSelectorView(
                selectedState: $viewModel.vacancy.state,
                states: viewModel.ibgeStates
            ).onDisappear {
                viewModel.handleChageSelectedState()
            }
        } label: {
            Text("UF")
            Spacer()
            Text(viewModel.vacancy.state)
        }
    }
    
    var citySelectorViewWithLink: some View {
        NavigationLink {
            CitySelectorView(
                showCitySelectorProgress: $viewModel.showCitySelectorProgress,
                selectedCity: $viewModel.vacancy.city,
                cities: viewModel.ibgeCities
            )
        } label: {
            Text("Cidade")
            Spacer()
            Text(viewModel.vacancy.city)
        }
        .disabled(viewModel.shouldDisableCitySelector)
    }
    
    var skillSection: some View {
        Section {
            ForEach(viewModel.expectedSkills) { skill in
                Text(skill.description)
                    .font(.system(size: 16, weight: .bold))
                    .swipeActions(edge: .trailing) {
                        Button (action: { viewModel.handleSelectDeleteSkill(skill: skill) }) {
                            Label("Delete", systemImage: "trash")
                        }.tint(.red)
                    }
            }
            
        } header: {
            HStack {
                setSectionHeader(title: "Crit??rios")
                Spacer()
                rightSectionHeaderButton
            }
        }
    }
    
    var rightSectionHeaderButton: some View {
        NavigationLink {
            ExpectedSkillSheetView(
                expectedSkills: $viewModel.expectedSkills,
                description: $viewModel.expectedSkill.description,
                profile: $viewModel.expectedSkill.desiredMinimumProfile,
                height: $viewModel.expectedSkill.height
            )
        } label: {
            Image(R.image.plus.name)
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18, alignment: .center)
        }
    }
    
    func setSectionHeader(title: String) -> some View {
        Text(title)
            .font(.system(size: 15, weight: .bold))
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

struct VacancyCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VacancyCreateView(viewModel: VacancyCreateViewModel())
                .preferredColorScheme($0)
        }
    }
}
