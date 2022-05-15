import SwiftUI

struct CitySelectorView: View {
    @Binding var selectedCity: String
    
    let cities: [IbgeCity]
    let title: String = "Escolha a cidade do estado"
    
    var body: some View {
        Form {
            Section(header: Text(title)) {
                List(cities, id: \.id) { city in
                    HStack {
                        Text(city.name)
                        Spacer()
                        Image(R.image.checkmark.name)
                            .foregroundColor(setCheckmarkIconColor(city: city.name))
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        handleSelectState(city: city.name)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func setCheckmarkIconColor(city: String) -> Color {
        selectedCity == city ? .orange : .clear
    }
    
    private func handleSelectState(city: String) {
        if !(selectedCity == city) {
            selectedCity = city
        }
    }
}

struct CitySelectorView_Previews: PreviewProvider {
    static var previews: some View {
        CitySelectorView(
            selectedCity: .constant("Rio de Janeiro"),
            cities: [IbgeCity(id: "21223", name: "Rio de Janeiro")]
        )
    }
}
