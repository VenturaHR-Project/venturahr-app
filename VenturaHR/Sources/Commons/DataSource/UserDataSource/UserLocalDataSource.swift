protocol UserLocalDataSourceProtocol {
    func saveAccountLocally(data: GenericUser)
    func getAccountType() -> String?
    func getUserUid() -> String?
    func getUserName() -> String?
    func getUserPhone() -> String?
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
    func saveAccountLocally(data: GenericUser) {
        userDefaultsManager.set(value: data.uid, for: .userUid)
        userDefaultsManager.set(value: data.name, for: .userName)
        userDefaultsManager.set(value: data.phone, for: .userPhone)
        userDefaultsManager.set(value: data.accountType, for: .userAccountType)
    }
    
    func getAccountType() -> String? {
        guard let accountType = userDefaultsManager.get(from: .userAccountType) as String? else { return nil }
        return accountType
    }
    
    func getUserUid() -> String? {
        guard let uid = userDefaultsManager.get(from: .userUid) as String? else { return nil }
        return uid
    }
    
    func getUserName() -> String? {
        guard let name = userDefaultsManager.get(from: .userName) as String? else { return nil }
        return name
    }
    
    func getUserPhone() -> String? {
        guard let name = userDefaultsManager.get(from: .userPhone) as String? else { return nil }
        return name
    }
}
