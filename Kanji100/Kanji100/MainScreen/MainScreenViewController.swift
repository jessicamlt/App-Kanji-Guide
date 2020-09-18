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
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        navigationItem.searchController = searchController
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.resignFirstResponder()
        searchController.obscuresBackgroundDuringPresentation = false

        searchWord(nil)
    }
    

    
    func setupTableView() {
        let nib = UINib(nibName: "KanjiTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
    }
    
    func searchWord(_ word: String?) {
        kanjis.kanjiList = filter.filter(searchedWord: word ?? "")
        tableView.reloadData()
    }

}

extension MainScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kanjis.kanjiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? KanjiTableViewCell else {
            fatalError("Cell not found")
        }
        
        cell.fillCell(kanji: kanjis.kanjiList[indexPath.row])
        
        return cell
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
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
