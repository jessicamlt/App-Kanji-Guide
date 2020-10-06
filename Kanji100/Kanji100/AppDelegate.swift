import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let screenFrame = UIScreen.main.bounds
        window = UIWindow(frame: screenFrame)
        
        window?.overrideUserInterfaceStyle = .light
        window?.tintColor = .white
        window?.rootViewController = createScreen()
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        return true
    }
    
    private func createScreen() -> UINavigationController {
        let favoriteManager = FavoriteManager()
        let mainScreen = MainScreenViewController.create(favoriteManager: favoriteManager)
        let mainScreenNavigationController = UINavigationController(rootViewController: mainScreen)
        mainScreenNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        mainScreenNavigationController.navigationBar.barTintColor = UIColor(named: "second")
        return mainScreenNavigationController
    }
}
