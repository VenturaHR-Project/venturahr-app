import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            MainViewRouter.makeVacanciesView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Home")
                }.tag(0)
            
            if viewModel.accountType.isCompany {
                MainViewRouter.makeVacancyCreateView()
                    .tabItem {
                        Image(systemName: "bag.fill.badge.plus")
                        Text("Nova Vaga")
                    }.tag(1)
            } else {
                MainViewRouter.makeVacanciesView()
                    .tabItem {
                        Image(systemName: "bag")
                        Text("Candidaturas")
                    }.tag(2)
                
            }
        }
        .accentColor(.orange)
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
