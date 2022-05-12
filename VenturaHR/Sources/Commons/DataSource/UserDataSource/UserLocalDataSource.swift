protocol UserLocalDataSourceProtocol {
    func getAccountType() -> String?
    func saveAccountType(value: String)
}

final class UserLocalDataSource {
    private var userDefaultsManager: UserDefaultsManagerProtocol
    
    init(
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.userDefaultsManager = userDefaultsManager
    }
}

extension UserLocalDataSource: UserLocalDataSourceProtocol {
    func getAccountType() -> String? {
        guard let accountType = userDefaultsManager.get(from: .userAccountType) as String? else { return nil }
        return accountType
    }
    
    func saveAccountType(value: String) {
        userDefaultsManager.set(value: value, for: .userAccountType)
    }
}
