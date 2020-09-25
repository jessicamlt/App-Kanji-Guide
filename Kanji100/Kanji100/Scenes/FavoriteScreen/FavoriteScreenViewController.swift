//
//  FavoriteScreenViewController.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 20/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

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
        kanjis = model.getFavoritesKanjis()
        tableHandler = TableHandler(tableView: tableView, scene: .favoriteScreen)
        tableHandler.kanjis = kanjis
        title = "Favorites"
        tableHandler.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        kanjis = model.getFavoritesKanjis()
        tableHandler.kanjis = kanjis
        favoriteManager.loadFavorites()
        tableHandler.reload()
    }
}

//MARK: - TableHandlerDelegate
extension FavoriteScreenViewController: TableHandlerDelegate {
    func cellDidDeselect(kanji: KanjiData) {
        model.removeFavorite(id: kanji.id)
        tableHandler.kanjis = kanjis
    }
    
    func cellDidSelect(kanji: KanjiData) {
        model.saveFavorite(id: kanji.id)
        tableHandler.kanjis = kanjis
    }
}
