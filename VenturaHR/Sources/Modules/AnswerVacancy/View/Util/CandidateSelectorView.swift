//import SwiftUI
//
//struct CandidateSelectorView: View {
//    @Binding var showCitySelectorProgress: Bool
//    @Binding var selectedCity: String
//    
//    let answers: [AnswerVacancyResponseDTO]
//    let title: String = "Escolha a cidade do estado"
//    
//    var body: some View {
//        ZStack {
//            if showCitySelectorProgress {
//                ProgressView()
//            } else {
//                Form {
//                    Section(header: Text(title)) {
//                        List(cities, id: \.id) { city in
//                            HStack {
//                                Text(city.name)
//                                Spacer()
//                                Image(R.image.checkmark.name)
//                                    .foregroundColor(setCheckmarkIconColor(city: city.name))
//                            }
//                            .contentShape(Rectangle())
//                            .onTapGesture {
//                                handleSelectState(city: city.name)
//                            }
//                        }
//                    }
//                }
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
//    }
//    
//    private func setCheckmarkIconColor(city: String) -> Color {
//        selectedCity == city ? .orange : .clear
//    }
//    
//    private func handleSelectState(city: String) {
//        if !(selectedCity == city) {
//            selectedCity = city
//        }
//    }
//}
//
//struct CandidateSelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        CandidateSelectorView()
//    }
//}
