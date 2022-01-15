import Foundation

final class DataStore {
    private static let backgroundKey = "backgroundKey"
    static var background: GradientData {
        get {
            if let data = UserDefaults.standard.object(forKey: backgroundKey) as? Data {
                let decoder = JSONDecoder()
                if let gradient = try? decoder.decode(GradientData.self, from: data) {
                    return gradient
                }
            }
            return ColorsStorage.default
        } set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: backgroundKey)
            }
        }
    }
    
    private static let initialHealthKey = "initialHealthKey"
    static var initialHealth: Int {
        get {
            UserDefaults.standard.value(forKey: initialHealthKey) as? Int ?? 20
        } set {
            UserDefaults.standard.setValue(newValue, forKey: initialHealthKey)
        }
    }
}
