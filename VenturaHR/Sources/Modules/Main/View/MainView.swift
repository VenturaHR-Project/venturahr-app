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
                Text("Ranking de Candidatos")
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                        Text("Ranking")
                    }.tag(2)
                
                MainViewRouter.makeVacancyCreateView()
                    .tabItem {
                        Image(systemName: "bag.fill.badge.plus")
                        Text("Nova Vaga")
                    }.tag(2)
            } else {
                MainViewRouter.makeVacanciesView()
                    .tabItem {
                        Image(systemName: "bag")
                        //Image(systemName: "chart.bar")
                        Text("Candidaturas")
                    }.tag(1)
                
            }
            
            Text("View 3")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag(2)
        }
        .accentColor(.orange)
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
