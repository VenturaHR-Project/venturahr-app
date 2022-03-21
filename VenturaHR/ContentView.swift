import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(R.string.localizable.helloWord())
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
