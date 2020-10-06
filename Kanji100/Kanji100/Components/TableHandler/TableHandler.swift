import UIKit

protocol TableHandlerDelegate: AnyObject {
    func cellDidDeselect(kanji: KanjiData)
    func cellDidSelect(kanji: KanjiData)
}

class TableHandler: NSObject, UITableViewDataSource {
    enum Scene {
        case mainScreen
        case favoriteScreen
        
        var placeholder: PlaceholderCellType {
            if self == .mainScreen {
                return .generalList
            }
            return .favoriteList
        }
    }
    
    private let tableView: UITableView
    private var kanjiListIsEmpty = true
    weak var delegate: TableHandlerDelegate?
    let scene: Scene
    var kanjis: [KanjiData] = [] {
        didSet {
            reload()
        }
    }
    
    init(tableView: UITableView, scene: Scene) {
        self.tableView = tableView
        self.scene = scene
        super.init()
        setupTableView()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(KanjiTableViewCell.nib, forCellReuseIdentifier: KanjiTableViewCell.identifier)
        tableView.register(PlaceholderTableViewCell.nib, forCellReuseIdentifier: PlaceholderTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
    }
    
    // MARK: - TableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if kanjis.isEmpty {
            kanjiListIsEmpty = true
            return 1
        }
        kanjiListIsEmpty = false
        return kanjis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if kanjiListIsEmpty {
            return buildPlaceholderCell(tableView: tableView, indexPath: indexPath)
        }
        return buildKanjiCell(tableView: tableView, indexPath: indexPath)
    }
    
    private func buildKanjiCell(tableView: UITableView, indexPath: IndexPath) -> KanjiTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KanjiTableViewCell.identifier, for: indexPath) as? KanjiTableViewCell else {
            fatalError("Cell not found")
        }
        let kanji = kanjis[indexPath.row]
        cell.fillCell(kanji: kanji)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    private func buildPlaceholderCell(tableView: UITableView, indexPath: IndexPath) -> PlaceholderTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderTableViewCell.identifier, for: indexPath) as? PlaceholderTableViewCell else {
            fatalError("Cell not found")
        }
        cell.placeholderCellType = scene.placeholder
        cell.fillCell()
        return cell
    }
}

// MARK: - KanjiTableViewCellDelegate
extension TableHandler: KanjiTableViewCellDelegate {
    func kanjiAddedToFavorite(kanji: KanjiData) {
        delegate?.cellDidSelect(kanji: kanji)
    }
    
    func kanjiRemovedFromFavorite(kanji: KanjiData) {
        delegate?.cellDidDeselect(kanji: kanji)
    }
}
