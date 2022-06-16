import SwiftUI
import PopupView

struct AnswerVacancyView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AnswerVacancyViewModel = AnswerVacancyViewModel()
    
    var userUid: String
    var vacancyId: String
    var expectedSkills: [ExpectedSkill]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        ForEach($viewModel.expectedSkills) { skill in
                            HStack {
                                Text(viewModel.showExpectedSkillName(skillId: skill.id))
                                
                                Spacer()
                                Picker("", selection: skill.desiredMinimumProfile) {
                                    ForEach(DesiredMinimumProfile.allCases, id: \.self) { type in
                                        Text(type.rawValue)
                                        
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .padding(.vertical, 10)
                            }
                        }
                    } header: {
                        sectionHeader
                    }
                }
                .onAppear {
                    viewModel.handleOnAppear(userUid: userUid,
                                             vacancyId: vacancyId,
                                             requiredSkills: expectedSkills)
                }
                .popup(
                    isPresented: $viewModel.shouldPresentPopup,
                    type: .floater(verticalPadding: 0, useSafeAreaInset: true),
                    position: .bottom,
                    animation: .easeIn,
                    autohideIn: 3,
                    dragToDismiss: true,
                    closeOnTap: true,
                    closeOnTapOutside: true,
                    dismissCallback: {
                        dismiss()
                    }
                ) {
                    ToastView(
                        imageName: R.image.checkmarkSeal.name,
                        message: "Resposta salva com sucesso!",
                        isDisabled: .constant(false)
                    )
                }
            }
            .navigationBarHidden(true)
        }
    }
}

private extension AnswerVacancyView {
    var sectionHeader: some View {
        HStack {
            Text("Resposta a vaga")
                .font(.system(size: 15, weight: .bold))
            
            Spacer()
            
            Button(action: viewModel.handleAnswerVacancy) {
                Text("Salvar")
                    .font(.system(size: 16, weight: .bold))
                    .padding(5)
                    .border(saveBarButtonColor)
            }
            .foregroundColor(saveBarButtonColor)
            .disabled(isSaveButtonDisabled)
        }
    }
    
    var saveBarButtonColor: Color {
        isSaveButtonDisabled ? .gray : .orange
    }
    
    var isSaveButtonDisabled: Bool {
        false
    }
}

struct AnswerVacancyView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerVacancyView(
            userUid: "g2f34f234f23432",
            vacancyId: "21e23ewasd",
            expectedSkills: [
                .init(description: "UML", desiredMinimumProfile: .medium, height: 1)
            ]
        )
    }
}
