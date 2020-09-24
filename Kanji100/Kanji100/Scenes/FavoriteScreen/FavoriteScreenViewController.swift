//
//  FavoriteScreenViewController.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 20/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import UIKit

class FavoriteScreenViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var favoriteManager = FavoriteManager()
    var kanjis: [Kanji] = []
    let favoritesFilter = FavoritesFilter(kanjis: KanjisRepository().convertJSON())
    var tableHandler: TableHandler!

    override func viewDidLoad() {
        super.viewDidLoad()
        kanjis = favoritesFilter.filter(favoritesList: FavoriteManager().list)
        tableHandler = TableHandler(tableView: tableView, favoriteManager: favoriteManager, scene: .favoriteScreen)
        tableHandler.kanjis = kanjis
        title = "Favorites"
        tableHandler.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        kanjis = favoritesFilter.filter(favoritesList: FavoriteManager().list)
        tableHandler.kanjis = kanjis
        favoriteManager.loadFavorites()
        tableHandler.reload()
    }
}

extension FavoriteScreenViewController: TableHandlerDelegate {
    func cellDidDeselect(at index: Int) {
        kanjis.remove(at: index)
        tableHandler.kanjis = kanjis
    }
    
}
