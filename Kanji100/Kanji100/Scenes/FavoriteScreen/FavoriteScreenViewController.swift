import UIKit

final class FavoriteScreenViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    
    private var favoriteManager: FavoriteManager
    private var kanjis: [KanjiData] = []
    private var tableHandler: TableHandler!
    private var model: FavoriteScreenModel
    
    init(favoriteManager: FavoriteManager, model: FavoriteScreenModel) {
        self.favoriteManager = favoriteManager
        self.model = model
        super.init(nibName: "FavoriteScreenViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableHandler = TableHandler(tableView: tableView, scene: .favoriteScreen)
        tableHandler.delegate = self
        title = "Favorites"
        updateKanjis()
        
        tableView.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        kanjis = model.getFavoritesKanjis()
        updateKanjis()
    }
    
    private func updateKanjis() {
        tableHandler.kanjis = model.getFavoritesKanjis()
    }
}

//MARK: - Create FavoriteScreen
extension FavoriteScreenViewController {
    static func create(favoriteManager: FavoriteManager) -> FavoriteScreenViewController {
        let model = FavoriteScreenModel(favoriteManager: favoriteManager)
        let favoriteScreenViewController = FavoriteScreenViewController(favoriteManager: favoriteManager, model: model)
        return favoriteScreenViewController
    }
}

//MARK: - TableHandlerDelegate
extension FavoriteScreenViewController: TableHandlerDelegate {
    func cellDidDeselect(kanji: KanjiData) {
        model.removeFavorite(id: kanji.id)
        updateKanjis()
    }
    
    func cellDidSelect(kanji: KanjiData) {
        model.saveFavorite(id: kanji.id)
        updateKanjis()
    }
}
