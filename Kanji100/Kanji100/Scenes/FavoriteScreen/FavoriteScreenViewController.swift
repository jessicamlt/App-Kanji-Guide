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
    var favoriteListIsEmpty = true

    override func viewDidLoad() {
        super.viewDidLoad()
        kanjis = favoritesFilter.filter(favoritesList: FavoriteManager().list)
        setupTableView()
        title = "Favorites"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        kanjis = favoritesFilter.filter(favoritesList: FavoriteManager().list)
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
        if kanjis.isEmpty {
            favoriteListIsEmpty = true
            return 1
        }
        favoriteListIsEmpty = false
        return kanjis.count
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

        let kanji = kanjis[indexPath.row]
        cell.fillCell(kanji: kanji, indexPath: indexPath, isFavorite: true)
        cell.delegate = self
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

extension FavoriteScreenViewController: KanjiTableViewCellDelegate {
    func kanjiAddedToFavorite(at indexPath: IndexPath) { /* Do nothing */ }
    
    func kanjiRemovedFromFavorite(at indexPath: IndexPath) {
        let kanji = kanjis[indexPath.row]
        favoriteManager.removeFavorite(id: kanji.id)
        kanjis = favoritesFilter.filter(favoritesList: favoriteManager.list)
        tableView.reloadData()
    }
}
