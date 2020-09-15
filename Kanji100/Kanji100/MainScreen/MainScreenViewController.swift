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
    var kanjis: [Kanji] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        kanjisRepository.convertJSON()
        
    }

}

extension MainScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kanjis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? KanjiTableViewCell else {
            fatalError("Cell not found")
        }
        
        cell.kanji = kanjis[indexPath.row]
        cell.fillCell()
        
        return cell
    }
}
