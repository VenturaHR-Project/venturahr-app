import SwiftUI
import PopupView

struct AddExpectedSkillSheetView: View {
    @State private var isShowingPopUp = false
    
    @Binding var expectedSkills: [ExpectedSkill]
    @Binding var text: String
    @Binding var profile: DesiredMinimumProfile
    @Binding var height: Int
    
    var body: some View {
        VStack {
            Form {
                Section {
                    VacancyEditTextField(
                        text: $text,
                        title: "Descrição",
                        placeholder: "Digite a Descrição da vaga"
                    )
                    
                    profileField
                    
                    heightField
                } header: {
                    sectionHeader
                }
            }
            .popup(
                isPresented: $isShowingPopUp,
                type: .floater(verticalPadding: 0, useSafeAreaInset: true),
                position: .bottom,
                animation: .easeIn,
                autohideIn: 3,
                dragToDismiss: false,
                closeOnTap: true,
                closeOnTapOutside: false,
                dismissCallback: {
                    isShowingPopUp = false
                }
            ) {
                ToastView(
                    imageName: R.image.checkmarkSeal.name,
                    message: "Critério salvo com sucesso!"
                )
            }
        }
    }
    
    var sectionHeader: some View {
        HStack {
            Text("Critérios")
                .font(.system(size: 15, weight: .bold))
            
            Spacer()
            
            Button(action: saveSkills) {
                Text("Salvar")
                    .font(.system(size: 16, weight: .bold))
                    .padding(5)
                    .border(saveBarButtonColor)
            }
            .foregroundColor(saveBarButtonColor)
            .disabled(isSaveButtonDisabled)
        }
    }
    
    var profileField: some View {
        HStack {
            Text("Profile")
            
            Spacer()
            Picker("Profile", selection: $profile) {
                ForEach(DesiredMinimumProfile.allCases, id: \.self) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.vertical, 10)
        }
    }
    
    var heightField: some View {
        Stepper(value: $height, in: 1...5) {
            Text("Peso")
            Text("\(height)")
        }
    }
    
    var saveBarButtonColor: Color {
        isSaveButtonDisabled ? .gray : .orange
    }
    
    var isSaveButtonDisabled: Bool {
        text.isEmpty || height == 0
    }
    
    func saveSkills() {
        let skill = ExpectedSkill(description: text,
                                  desiredMinimumProfile: profile,
                                  height: height)
        
        expectedSkills.append(skill)
        isShowingPopUp = true
    }
}

struct AddExpectedSkillSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpectedSkillSheetView(
            expectedSkills: .constant(
                [.init(description: "",
                       desiredMinimumProfile: .medium,
                       height: 1)
                ]
            ),
            text: .constant("Desenvolvedor Java"),
            profile: .constant(.medium),
            height: .constant(3)
        )
    }
}
