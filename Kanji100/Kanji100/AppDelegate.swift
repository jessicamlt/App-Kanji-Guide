import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let screenFrame = UIScreen.main.bounds
        window = UIWindow(frame: screenFrame)
        let favoriteManager = FavoriteManager()
        
        let mainScreenNavigationController = createMainScreen(favoriteManager: favoriteManager)
        let favoriteScreenNavigationController = createFavoriteScreen(favoriteManager: favoriteManager)
        
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = mainScreenNavigationController
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        return true
    }
    
    func createMainScreen(favoriteManager: FavoriteManager) -> UINavigationController {
        let model = MainScreenModel(favoriteManager: favoriteManager)
        let mainScreenViewController = MainScreenViewController(favoriteManager: favoriteManager, model: model)
        let mainScreenNavigationController = UINavigationController(rootViewController: mainScreenViewController)
        mainScreenNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        mainScreenNavigationController.navigationBar.barTintColor = UIColor(named: "second")
//        let searchNavigationItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
//        let favoriteNavigationItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
//        searchNavigationItem.tintColor = .white
//        favoriteNavigationItem.tintColor = .white
//        mainScreenNavigationController.navigationItem.leftBarButtonItem = searchNavigationItem
//        mainScreenNavigationController.navigationItem.rightBarButtonItem = favoriteNavigationItem
        return mainScreenNavigationController
    }
    
    func createFavoriteScreen(favoriteManager: FavoriteManager) -> UINavigationController {
        let model = FavoriteScreenModel(favoriteManager: favoriteManager)
        let favoriteScreenViewController = FavoriteScreenViewController(favoriteManager: favoriteManager, model: model)
        let favoriteScreenNavigationController = UINavigationController(rootViewController: favoriteScreenViewController)
        favoriteScreenNavigationController.title = "Favorites"
        favoriteScreenNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        favoriteScreenNavigationController.navigationBar.barTintColor = UIColor(named: "second")
        
        return favoriteScreenNavigationController
    }
}
