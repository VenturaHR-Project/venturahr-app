import SwiftUI

struct VacancyCardView: View {
    
    @State var accountType: AccountType
    
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

private extension VacancyCardView {
    var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Desenvolvedor Mobile II")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.bottom, 5)
                
                Spacer()
                
                Label {
                    Text("Publicada")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName:  "circlebadge.2.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 11, weight: .bold))
                }
            }
            
            Label("Rio de Janeiro - RJ", systemImage: "mappin.and.ellipse")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.gray)
                .padding(.bottom, 10)
        }
        .accessibilityAddTraits(.isHeader)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Lorem ipsum metus ante sollicitudin quisque maecenas consequat primis.")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
                .padding(.bottom)
                .lineLimit(5)
            
            HStack {
                Label("Infnet", systemImage: "building")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                Label("CLT", systemImage: "doc.text")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                Label("Período integral", systemImage: "timer")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
            }
            
            Label("Expira em 01/07/2022", systemImage: "calendar")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
                .padding(.bottom, 10)
        }
        .padding(.top, 10)
    }
    
    var candidateFooter: some View {
        LoadingButtonView(
            viewData: LoadingButtonViewData(
                action: { print("teste") },
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

struct VacancyCardView_Previews: PreviewProvider {
    static var previews: some View {
        VacancyCardView(accountType: .company)
    }
}
