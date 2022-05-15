import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Text("View 1")
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Home")
                }.tag(0)
            
            MainViewRouter.makeVacancyView()
                .tabItem {
                    Image(systemName: "bag")
                    //Image(systemName: "chart.bar")
                    Text("Vagas")
                }.tag(1)
            
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
