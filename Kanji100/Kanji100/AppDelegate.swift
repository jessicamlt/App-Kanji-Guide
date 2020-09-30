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
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainScreenNavigationController, favoriteScreenNavigationController]
        tabBarController.selectedViewController = mainScreenNavigationController
        
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        return true
    }
    
    func createMainScreen(favoriteManager: FavoriteManager) -> UINavigationController {
        let model = MainScreenModel(favoriteManager: favoriteManager)
        let mainScreenViewController = MainScreenViewController(favoriteManager: favoriteManager, model: model)
        let mainScreenNavigationController = UINavigationController(rootViewController: mainScreenViewController)
        let mainScreenTabBarItem = UITabBarItem(title: "All Kanjis", image: UIImage(systemName: "book.fill"), tag: 0)
        mainScreenNavigationController.tabBarItem = mainScreenTabBarItem
        return mainScreenNavigationController
    }
    
    func createFavoriteScreen(favoriteManager: FavoriteManager) -> UINavigationController {
        let model = FavoriteScreenModel(favoriteManager: favoriteManager)
        let favoriteScreenViewController = FavoriteScreenViewController(favoriteManager: favoriteManager,
                                                                        model: model)
        let favoriteScreenNavigationController = UINavigationController(rootViewController: favoriteScreenViewController)
        let favoriteScreenTabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        favoriteScreenNavigationController.tabBarItem = favoriteScreenTabBarItem
        return favoriteScreenNavigationController
    }
}
