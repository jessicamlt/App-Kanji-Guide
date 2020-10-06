import UIKit
import FirebaseAnalytics

final class MainScreenViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var topContraint: NSLayoutConstraint!
    
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
        tableView.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
        
        tableHandler = TableHandler(tableView: tableView, scene: .mainScreen)
        tableHandler.delegate = self
        tableHandler.kanjis = []
        
        searchTextField.delegate = self
        
        searchWord(nil)
        setupNavigationBar()
        setupSearchBar()
        hideSearchBar(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchWord(searchTerm)
    }
    
    @IBAction func search(_ sender: UIButton) {
        searchWord(searchTextField.text)
        searchTextField.resignFirstResponder()
    }
    
    @IBAction func cancelSearch(_ sender: UIButton) {
        hideSearchBar(animated: true)
    }
    
    private func setupSearchBar() {
        searchButton.layer.cornerRadius = 8.0
        searchButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = 8.0
        cancelButton.layer.masksToBounds = true
        searchView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        searchView.layer.cornerRadius = 16.0
    }
    
    private func hideSearchBar(animated: Bool) {
        if !animated {
            topContraint.constant = -searchView.bounds.height
            searchTextField.resignFirstResponder()
            return
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.topContraint.constant = -(self?.searchView.bounds.height ?? 0)
            self?.view.layoutIfNeeded()
        } completion: { _ in
            self.searchTextField.resignFirstResponder()
        }
    }
    
    private func showSearchBar(animated: Bool) {
        if !animated {
            topContraint.constant = 0
            searchTextField.becomeFirstResponder()
            return
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.topContraint.constant = 0
            self?.view.layoutIfNeeded()
        } completion: { _ in
            self.searchTextField.becomeFirstResponder()
        }
    }
    
    @objc private func toggleSearchBar() {
        if topContraint.constant == 0 {
            hideSearchBar(animated: true)
            return
        }
        showSearchBar(animated: true)
    }
    
    private func setupNavigationBar() {
        let searchNavigationItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toggleSearchBar))
        let favoriteNavigationItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(goToFavoriteScreen))
        searchNavigationItem.tintColor = .white
        favoriteNavigationItem.tintColor = .white
        navigationItem.leftBarButtonItem = searchNavigationItem
        navigationItem.rightBarButtonItem = favoriteNavigationItem
    }
    
    @objc private func goToFavoriteScreen() {
        let vc = FavoriteScreenViewController.create(favoriteManager: favoriteManager)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func searchWord(_ word: String?) {
        tableHandler.kanjis = model.getKanjis(searchedWord: word ?? "")
        guard let searchText = word, searchText.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            title = "All Kanjis"
            return
        }
        title = searchText
    }
}

//MARK: - UITextFieldDelegate
extension MainScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchWord(searchTextField.text)
        searchTextField.resignFirstResponder()
        return true
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

//MARK: - TableHandlerDelegate
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
