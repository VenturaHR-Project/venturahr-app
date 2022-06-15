import SwiftUI

struct VacanciesCardView: View {
    @State var accountType: AccountType
    @State var viewData: VacancyViewData
    @State var viewModel: VacanciesViewModel
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: EmptyView(),
                isActive: .constant(false),
                label: {
                    EmptyView()
                }
            )
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    header
                    
                    Divider()
                    
                    content
                }
                
                Divider()
                
                switch accountType {
                case .candidate:
                    candidateFooter
                case .company:
                    companyFooter
                }
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .frame(idealWidth: .infinity, maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color.orange, lineWidth: 1.4)
                .shadow(color: .gray, radius: 2, x: 2.0, y: 2.0)
        )
        .padding(.horizontal)
    }
}

private extension VacanciesCardView {
    var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(viewData.ocupation)
                    .font(.system(size: 14, weight: .bold))
                    .padding(.bottom, 5)
                
                Spacer()
                
                Label {
                    Text(viewData.status)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName:  "circlebadge.2.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 11, weight: .bold))
                }
            }
            
            Label("\(viewData.city) - \(viewData.state)", systemImage: "mappin.and.ellipse")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.gray)
                .padding(.bottom, 10)
        }
        .accessibilityAddTraits(.isHeader)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewData.description)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
                .padding(.bottom)
                .lineLimit(5)
            
            HStack {
                Label(viewData.company, systemImage: "building")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                Label(viewData.jobType.rawValue, systemImage: "doc.text")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                Label(viewData.hiringPeriod.rawValue, systemImage: "timer")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
            }
            
            Label("Expira em \(viewData.expiresAt)", systemImage: "calendar")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
                .padding(.bottom, 10)
        }
        .padding(.top, 10)
    }
    
    var candidateFooter: some View {
        LoadingButtonView(
            viewData: LoadingButtonViewData(
                action: { viewModel.handleShowAnswerVacancySheet(viewData: viewData) },
                buttonTitle: "Quero me candidatar",
                showProgress: false,
                disabled: false,
                verticalPadding: 6
            )
        )
        .padding(.vertical, 10)
    }
    
    var companyFooter: some View {
        HStack {
            Button(action: {  }) {
                Text("Editar")
                    .bold()
                    .padding(5)
                    .border(.blue)
            }
            .foregroundColor(.blue)
            
            Spacer()
            
            Button(action: {  }) {
                Text("Apagar")
                    .bold()
                    .padding(5)
                    .border(.red)
            }
            .foregroundColor(.red)
        }
        .padding(.vertical, 10)
    }
}

struct VacanciesCardView_Previews: PreviewProvider {
    static var previews: some View {
        VacanciesCardView(
            accountType: .company,
            viewData: VacancyViewData.vacancyViewDataMock,
            viewModel: VacanciesViewModel()
        )
    }
}
