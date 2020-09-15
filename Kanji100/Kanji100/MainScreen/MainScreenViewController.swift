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
    
    
    var kanjisRepository = KanjisRepository()
    var kanjis: Kanjis!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        kanjis = kanjisRepository.convertJSON()
        tableView.reloadData()
        
    }
    
    func setupTableView() {
        let nib = UINib(nibName: "KanjiTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
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
        
        cell.kanji = kanjis.kanjiList[indexPath.row]
        cell.fillCell()
        
        return cell
    }
}
