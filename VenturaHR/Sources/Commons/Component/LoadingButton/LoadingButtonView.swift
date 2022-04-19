import SwiftUI

struct LoadingButtonView: View {
    var viewData: LoadingButtonViewData
    
    var body: some View {
        ZStack {
            Button(action: viewData.action) {
                Text(title)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.system(.title3).bold())
                    .padding(.vertical, 14).padding(.horizontal, 16)
                    .background(backgroundColor)
                    .cornerRadius(4.0)
            }.disabled(isDisabled)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(viewData.showProgress ? 1 : 0)
        }
    }
    
    var title: String {
        viewData.showProgress ? "" : viewData.buttonTitle
    }
    
    var backgroundColor: Color {
        viewData.disabled ? Color.gray : Color.orange
    }
    
    var isDisabled: Bool {
        viewData.disabled || viewData.showProgress
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let viewData: LoadingButtonViewData = .init(action: { print("Hello Word") },
                                                    buttonTitle: "Entrar",
                                                    showProgress: false,
                                                    disabled: false)
        
        ForEach(ColorScheme.allCases, id: \.self) {
            LoadingButtonView(viewData: viewData)
                .preferredColorScheme($0)
                .padding()
        }
    }
}
