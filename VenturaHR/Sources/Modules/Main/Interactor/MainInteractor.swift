import Combine

protocol MainInteractorProtocol {
    func handleGetAccountType() -> String?
}

final class MainInteractor {
    private let userLocalDataSource: UserLocalDataSourceProtocol
    
    init(userLocalDataSource: UserLocalDataSourceProtocol = UserLocalDataSource()) {
        self.userLocalDataSource = userLocalDataSource
    }
}

extension MainInteractor: MainInteractorProtocol {
    func handleGetAccountType() -> String? {
        return userLocalDataSource.getAccountType()
    }
}
