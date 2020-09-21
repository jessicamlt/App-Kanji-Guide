//
//  FavoriteScreenViewController.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 20/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import UIKit

class FavoriteScreenViewController: UIViewController {

//    @IBOutlet var tableView: UITableView!
//
//    var kanjis = Kanjis(kanjiList: [])
//    var favoriteIdsList = (UserDefaults.standard.array(forKey: "ids") as? [Int]) ?? []
//    var favoriteListIsEmpty = true
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView()
//
//    }
//
//    func setupTableView() {
//        tableView.register(KanjiTableViewCell.nib, forCellReuseIdentifier: KanjiTableViewCell.identifier)
//        tableView.register(PlaceholderTableViewCell.nib, forCellReuseIdentifier: PlaceholderTableViewCell.identifier)
//        tableView.separatorStyle = .none
//        tableView.dataSource = self
//    }
//}
//
//extension FavoriteScreenViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if favoriteIdsList.isEmpty {
//            favoriteListIsEmpty = true
//            return 1
//        }
//        favoriteListIsEmpty = false
//        return favoriteIdsList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if !favoriteListIsEmpty {
//             return buildKanjiCell(tableView: tableView, indexPath: indexPath)
//        }
//         return buildPlaceholderCell(tableView: tableView, indexPath: indexPath)
//    }
//
//    func buildKanjiCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: KanjiTableViewCell.identifier, for: indexPath) as? KanjiTableViewCell else {
//            fatalError("Cell not found")
//        }
//        cell.kanji = favoriteList[indexPath.row]
//        cell.fillCell()
//        return cell
//    }
//
//    func buildPlaceholderCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//
//    }


}
