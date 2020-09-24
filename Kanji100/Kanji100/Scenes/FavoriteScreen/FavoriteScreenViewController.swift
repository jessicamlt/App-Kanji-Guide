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
    private var kanjis: [Kanji] = []
    private let favoritesFilter = FavoritesFilter(kanjis: KanjisRepository().getKanjis())
    private var tableHandler: TableHandler!
    
    init(favoriteManager: FavoriteManager) {
        self.favoriteManager = favoriteManager
        super.init(nibName: "FavoriteScreenViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

//MARK: - TableHandlerDelegate
extension FavoriteScreenViewController: TableHandlerDelegate {
    func cellDidDeselect(at index: Int) {
        kanjis.remove(at: index)
        tableHandler.kanjis = kanjis
    }
}
