//
//  TableHandler.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 23/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import UIKit

protocol TableHandlerDelegate: AnyObject {
    func cellDidDeselect(at index: Int)
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
    private let favoriteManager: FavoriteManager
    private var kanjiListIsEmpty = true
    weak var delegate: TableHandlerDelegate?
    let scene: Scene
    var kanjis: [Kanji] = [] {
        didSet {
            reload()
        }
    }
    
    init(tableView: UITableView, favoriteManager: FavoriteManager, scene: Scene) {
        self.tableView = tableView
        self.favoriteManager = favoriteManager
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
        let isFavorite = favoriteManager.contains(id: kanjis[indexPath.row].id)
        cell.fillCell(kanji: kanji, indexPath: indexPath, isFavorite: isFavorite)
        cell.delegate = self
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
    func kanjiAddedToFavorite(at indexPath: IndexPath) {
        let kanji = kanjis[indexPath.row]
        favoriteManager.saveFavorite(id: kanji.id)
        reload()
    }
    
    func kanjiRemovedFromFavorite(at indexPath: IndexPath) {
        let kanji = kanjis[indexPath.row]
        favoriteManager.removeFavorite(id: kanji.id)
        reload()
        delegate?.cellDidDeselect(at: indexPath.row)
    }
}
