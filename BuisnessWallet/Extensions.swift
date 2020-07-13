import UIKit

extension UserDefaults {

    // Mark: UIColor extension
    
    func color(forKey key: String) -> UIColor {
        let backupColor = UIColor(named: UIColorKeys.accentColor.rawValue)!
        guard let colorData = data(forKey: key) else { return backupColor }
        return (try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)) ?? backupColor
    }

    func set(_ value: UIColor?, forKey key: String) {
        guard let color = value, let data = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) else { return }
        set(data, forKey: key)
    }

    // Mark UIImage extension
    
    func image(forKey key: String) -> UIImage? {
        guard let jpegData = data(forKey: key) else { return nil }
        return UIImage(data: jpegData)
    }

    func set(_ value: UIImage?, forKey key: String) {
        guard let jpegData = value?.jpegData(compressionQuality: 0.8) else { return }
        set(jpegData, forKey: key)
    }

}
