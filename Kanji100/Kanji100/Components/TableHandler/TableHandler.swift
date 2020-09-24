//
//  TableHandler.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 23/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import UIKit

class TableHandler: NSObject, UITableViewDataSource {
    private let tableView: UITableView
    private let favoriteManager: FavoriteManager
    private var kanjiListIsEmpty = true
    var kanjis: [Kanji] = [] {
        didSet {
            reload()
        }
    }
    
    
    init(tableView: UITableView, favoriteManager: FavoriteManager) {
        self.tableView = tableView
        self.favoriteManager = favoriteManager
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
        let isFavorite = favoriteManager.contains(id: kanjis[indexPath.row].id)
        cell.fillCell(kanji: kanji, indexPath: indexPath, isFavorite: isFavorite)
        cell.delegate = self
        return cell
    }
    
    private func buildPlaceholderCell(tableView: UITableView, indexPath: IndexPath) -> PlaceholderTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderTableViewCell.identifier, for: indexPath) as? PlaceholderTableViewCell else {
            fatalError("Cell not found")
        }
        
        cell.principalImageView.image = UIImage(named: "Lupa")
        cell.titleLabel.text = "We're sorry"
        cell.messageLabel.text = "We can't find the word that you're looking for..."
        
        return cell
    }
}

extension TableHandler: KanjiTableViewCellDelegate {
    func kanjiAddedToFavorite(at indexPath: IndexPath) {
        let kanji = kanjis[indexPath.row]
        favoriteManager.saveFavorite(id: kanji.id)
        reload()
        
    }
    
    func kanjiRemovedFromFavorite(at indexPath: IndexPath) {
        let kanji = kanjis[indexPath.row]
        favoriteManager.removeFavorite(id: kanji.id)
        reload()
    }
    
    
}
