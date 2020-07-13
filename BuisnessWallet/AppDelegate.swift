import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        return true
    }

}

enum UserDefaultKeys: String {
    case fullName     = "userFullName"
    case telephone    = "userPhoneNumber"
    case emailAddress = "userEmailAddress"
    case website      = "userWebsite"
    case description  = "userDescription"
    
    case avatarImage     = "userAvatarImage"
    case backgroundImage = "userBackgroundImage"
    case backgroundColor = "userBackgroundColor"
}

enum UIImageKeys: String {
    case fullName     = "signature"
    case telephone    = "phone"
    case emailAddress = "envelope-open-text"
    case website      = "server"
    case description  = "award"
    
    case avatarImage     = "user-circle"
    case backgroundImage = "image"
    case backgroundColor = "fill-drip"
}

enum UIColorKeys: String {
    case accentColor = "AccentColor"
}
