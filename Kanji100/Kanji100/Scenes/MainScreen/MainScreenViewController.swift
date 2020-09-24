//
//  MainScreenViewController.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 14/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var kanjis = Kanjis(kanjiList: [])
    let filter = WordsFilter(kanjis: KanjisRepository().convertJSON()) //Model
    let favoriteManager = FavoriteManager()
    var tableHandler: TableHandler!
    var searchTerm: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableHandler = TableHandler(tableView: tableView, favoriteManager: favoriteManager, scene: .mainScreen)
        tableHandler.kanjis = []
        setupSearchController()
        searchWord(nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favoriteManager.loadFavorites()
        tableHandler.reload()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.resignFirstResponder()
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func searchWord(_ word: String?) {
        tableHandler.kanjis = filter.filter(searchedWord: word ?? "")
        tableView.reloadData()
        guard let searchText = word, searchText.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            title = "All Kanjis"
            return
        }
        title = searchText
    }
}

// MARK: - SearchBarDelegate
extension MainScreenViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text ?? ""
        searchWord(searchTerm)
        searchController.dismiss(animated: true, completion: nil)
    }
}

//MARK: - SearchControllerDelegate
extension MainScreenViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        searchController.searchBar.text = searchTerm
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.text = searchTerm
    }
}

//MARK: - SearchResultsUpdating
extension MainScreenViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
