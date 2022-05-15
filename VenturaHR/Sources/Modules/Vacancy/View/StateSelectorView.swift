import SwiftUI

struct StateSelectorView: View {
    @Binding var selectedState: String

    let states: [IbgeState]
    let title: String = "Escolha o estado"
    
    var body: some View {
        Form {
            Section(header: Text(title)) {
                List(states, id: \.id) { state in
                    HStack {
                        Text(state.acronym)
                        Spacer()
                        Image(R.image.checkmark.name)
                            .foregroundColor(setCheckmarkIconColor(acronym: state.acronym))
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        handleSelectState(acronym: state.acronym)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func setCheckmarkIconColor(acronym: String) -> Color {
        selectedState == acronym ? .orange : .clear
    }
    
    private func handleSelectState(acronym: String) {
        if !(selectedState == acronym) {
            selectedState = acronym
        }
    }
}

struct StateSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            StateSelectorView(selectedState: .constant("RJ"),
                              states: [
                                IbgeState(id: 0,
                                          acronym: "RJ",
                                          name: "Rio de Janeiro",
                                          region: .init(id: 0, acronym: "", name: ""))
                              ])
                .colorScheme($0)
        }
    }
}
