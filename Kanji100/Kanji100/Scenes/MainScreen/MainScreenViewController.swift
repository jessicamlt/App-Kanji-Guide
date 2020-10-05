import UIKit
import FirebaseAnalytics

final class MainScreenViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    //private let searchController = UISearchController(searchResultsController: nil)
    private var kanjis = Kanjis(kanjiList: [])
    private let favoriteManager: FavoriteManager
    private var tableHandler: TableHandler!
    private var searchTerm: String? = ""
    private let model: MainScreenModel
    
    init(favoriteManager: FavoriteManager, model: MainScreenModel) {
        self.favoriteManager = favoriteManager
        self.model = model
        super.init(nibName: "MainScreenViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableHandler = TableHandler(tableView: tableView, scene: .mainScreen)
        tableHandler.delegate = self
        tableHandler.kanjis = []
        //setupSearchController()
        searchWord(nil)
        setupNavigationBar()
        
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "id-\(title!)",
          AnalyticsParameterItemName: title!,
          AnalyticsParameterContentType: "cont"
          ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchWord(searchTerm)
    }
    
    private func setupNavigationBar() {
        let searchNavigationItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        let favoriteNavigationItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(goToFavoriteScreen))
        searchNavigationItem.tintColor = .white
        favoriteNavigationItem.tintColor = .white
        navigationItem.leftBarButtonItem = searchNavigationItem
        navigationItem.rightBarButtonItem = favoriteNavigationItem
    }
    
    @objc func goToFavoriteScreen() {
        let vc = FavoriteScreenViewController.create(favoriteManager: favoriteManager)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    private func setupSearchController() {
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
//        searchController.delegate = self
//        searchController.searchBar.enablesReturnKeyAutomatically = false
//        searchController.searchBar.resignFirstResponder()
//        searchController.obscuresBackgroundDuringPresentation = false
//        navigationItem.searchController = searchController
//    }
    
    private func searchWord(_ word: String?) {
        tableHandler.kanjis = model.getKanjis(searchedWord: word ?? "")
        guard let searchText = word, searchText.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            title = "All Kanjis"
            return
        }
        title = searchText
    }
}

//MARK: - Create MainScreen

extension MainScreenViewController {
    static func create(favoriteManager: FavoriteManager) -> MainScreenViewController {
        let model = MainScreenModel(favoriteManager: favoriteManager)
        let mainScreenViewController = MainScreenViewController(favoriteManager: favoriteManager, model: model)
        return mainScreenViewController
    }
}

//MARK: - SearchBarDelegate
extension MainScreenViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text ?? ""
        searchWord(searchTerm)
        //searchController.dismiss(animated: true, completion: nil)
    }
}

//MARK: - SearchControllerDelegate
extension MainScreenViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        searchController.searchBar.text = searchTerm
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.text = searchTerm
    }
}

//MARK: - SearchResultsUpdating
extension MainScreenViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension MainScreenViewController: TableHandlerDelegate {
    func cellDidSelect(kanji: KanjiData) {
        model.saveFavorite(id: kanji.id)
        searchWord(searchTerm)
    }
    
    func cellDidDeselect(kanji: KanjiData) {
        model.removeFavorite(id: kanji.id)
        searchWord(searchTerm)
    }
}
