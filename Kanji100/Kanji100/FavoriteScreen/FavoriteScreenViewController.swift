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
    
    var favoriteIdsList = FavoriteManager().list
    var favoriteManager = FavoriteManager()
    var kanjis = FavoritesFilter(kanjis: KanjisRepository().convertJSON(), favoritesList: FavoriteManager().list).filter()
    var favoriteListIsEmpty = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favoriteIdsList = FavoriteManager().list
        kanjis = FavoritesFilter(kanjis: KanjisRepository().convertJSON(), favoritesList: favoriteIdsList).reloadFilter()
        tableView.reloadData()
    }

    func setupTableView() {
        tableView.register(KanjiTableViewCell.nib, forCellReuseIdentifier: KanjiTableViewCell.identifier)
        tableView.register(PlaceholderTableViewCell.nib, forCellReuseIdentifier: PlaceholderTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
    }
}

extension FavoriteScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoriteIdsList.isEmpty {
            favoriteListIsEmpty = true
            return 1
        }
        favoriteListIsEmpty = false
        return favoriteIdsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !favoriteListIsEmpty {
             return buildKanjiCell(tableView: tableView, indexPath: indexPath)
        }
         return buildPlaceholderCell(tableView: tableView, indexPath: indexPath)
    }

    func buildKanjiCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KanjiTableViewCell.identifier, for: indexPath) as? KanjiTableViewCell else {
            fatalError("Cell not found")
        }
        
        cell.favoriteManager = favoriteManager
        cell.kanji = kanjis[indexPath.row]
        cell.isFavorite = favoriteManager.contains(id: kanjis[indexPath.row].id)
        cell.fillCell()
        return cell
    }

    func buildPlaceholderCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderTableViewCell.identifier, for: indexPath) as? PlaceholderTableViewCell else {
            fatalError("Cell not found")
        }
        cell.principalImageView.image = UIImage(named: "lista")
        cell.titleLabel.text = "Favorites List"
        cell.messageLabel.text = "Save you favorite kanji, you will find them collect here!"
        
        return cell
    }


}
