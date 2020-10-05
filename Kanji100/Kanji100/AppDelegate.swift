import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let screenFrame = UIScreen.main.bounds
        window = UIWindow(frame: screenFrame)
        
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = createScreen()
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        return true
    }
    
    func createScreen() -> UINavigationController {
        let favoriteManager = FavoriteManager()
        let mainScreen = MainScreenViewController.create(favoriteManager: favoriteManager)
        let mainScreenNavigationController = UINavigationController(rootViewController: mainScreen)
        mainScreenNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        mainScreenNavigationController.navigationBar.barTintColor = UIColor(named: "second")
        return mainScreenNavigationController
    }
    
//    func createMainScreen(favoriteManager: FavoriteManager) -> UINavigationController {
//        let model = MainScreenModel(favoriteManager: favoriteManager)
//        let mainScreenViewController = MainScreenViewController(favoriteManager: favoriteManager, model: model)
//        let mainScreenNavigationController = UINavigationController(rootViewController: mainScreenViewController)
//        mainScreenNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        mainScreenNavigationController.navigationBar.barTintColor = UIColor(named: "second")
//        return mainScreenNavigationController
//    }
    
//    func createFavoriteScreen(favoriteManager: FavoriteManager) -> UINavigationController {
//        let model = FavoriteScreenModel(favoriteManager: favoriteManager)
//        let favoriteScreenViewController = FavoriteScreenViewController(favoriteManager: favoriteManager, model: model)
//        let favoriteScreenNavigationController = UINavigationController(rootViewController: favoriteScreenViewController)
//        favoriteScreenNavigationController.title = "Favorites"
//        favoriteScreenNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        favoriteScreenNavigationController.navigationBar.barTintColor = UIColor(named: "second")
//        
//        return favoriteScreenNavigationController
//    }
}
