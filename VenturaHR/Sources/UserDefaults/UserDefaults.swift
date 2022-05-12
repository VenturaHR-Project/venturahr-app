import Foundation

protocol UserDefaultsManagerProtocol {
    func get<T>(from key: UserDefaultsKeys) -> T?
    func set(value: Any?, for key: UserDefaultsKeys)
}

class UserDefaultsManager {
    private var userDefaults: UserDefaults
    
    init() {
        self.userDefaults = .standard
    }
}

extension UserDefaultsManager: UserDefaultsManagerProtocol {
    func get<T>(from key: UserDefaultsKeys) -> T? {
        return userDefaults.object(forKey: key.rawValue) as? T
    }
    
    func set(value: Any?, for key: UserDefaultsKeys) {
        userDefaults.set(value, forKey: key.rawValue)
    }
}
