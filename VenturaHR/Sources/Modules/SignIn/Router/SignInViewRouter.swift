import SwiftUI

struct SignInViewRouter {
    static func start() -> some View {
        return SignInView()
    }
    
    static func makeMainScreen() -> some View {
        return MainView()
    }
}
