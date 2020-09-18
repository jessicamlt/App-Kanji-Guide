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
    let filter = WordsFilter(kanjis: KanjisRepository().convertJSON())
    
    var searchTerm: String? = ""
    var wordNotFound = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.resignFirstResponder()
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController


        searchWord(nil)
    }
    

    
    func setupTableView() {
        tableView.register(KanjiTableViewCell.nib, forCellReuseIdentifier: KanjiTableViewCell.identifier)
        tableView.register(PlaceholderTableViewCell.nib, forCellReuseIdentifier: PlaceholderTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
    }
    
    func searchWord(_ word: String?) {
        kanjis.kanjiList = filter.filter(searchedWord: word ?? "")
        tableView.reloadData()
        
        guard let searchText = word, searchText.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            title = "All Kanjis"
            return
        }
        title = searchText
    }

}

extension MainScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if kanjis.kanjiList.isEmpty {
            wordNotFound = true
            return 1
        }
        wordNotFound = false
        return kanjis.kanjiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if wordNotFound {
            return buildPlaceholderCell(tableView: tableView, indexPath: indexPath)
            
        }
        return buildKanjiCell(tableView: tableView, indexPath: indexPath)

    }
    
    func buildKanjiCell(tableView: UITableView, indexPath: IndexPath) -> KanjiTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KanjiTableViewCell.identifier, for: indexPath) as? KanjiTableViewCell else {
            fatalError("Cell not found")
        }
        cell.fillCell(kanji: kanjis.kanjiList[indexPath.row])
        return cell
    }
    
    func buildPlaceholderCell(tableView: UITableView, indexPath: IndexPath) -> PlaceholderTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceholderTableViewCell.identifier, for: indexPath) as? PlaceholderTableViewCell else {
            fatalError("Cell not found")
        }
        
        return cell
    }
}

extension MainScreenViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text ?? ""
        searchWord(searchTerm)
        searchController.dismiss(animated: true, completion: nil)

    }
    
}

extension MainScreenViewController: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        searchController.searchBar.text = searchTerm
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.text = searchTerm
    }

}

extension MainScreenViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
    }

}
