//
//  KanjiTableViewCell.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 14/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import UIKit

class KanjiTableViewCell: UITableViewCell {
    
    @IBOutlet var kanjiLabel: UILabel!
    @IBOutlet var englishMeaningLabel: UILabel!
    @IBOutlet var onyomyReadLabel: UILabel!
    @IBOutlet var kunyomiReadLabel: UILabel!
    @IBOutlet var examplesLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    static let nib = UINib(nibName: "KanjiTableViewCell", bundle: nil)
    static let identifier = "cell"
    
    var isFavorite = false {
        didSet {
            fillCell()
        }
    }
    
    let favoriteManager = FavoriteManager()
    var kanji: Kanji!


    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func makeFavorite(_ sender: UIButton) {
        if favoriteManager.contains(id: kanji.id) {
            favoriteManager.removeFavorite(id: kanji.id)
            isFavorite = false
            //favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            return
        }
        favoriteManager.saveFavorite(id: kanji.id)
        isFavorite = true
//        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    
    func fillCell() {
        kanjiLabel.text = kanji.kanji
        englishMeaningLabel.text = kanji.englishMeanings.joined(separator: ", ")
        onyomyReadLabel.text = kanji.onyomy.joined(separator: " / ")
        kunyomiReadLabel.text = kanji.kunyomi.joined(separator: " / ")
        
        let examplesCollection = kanji.examples
        var examples: [String] = []
        for word in examplesCollection {
            examples.append(word.examples)
        }
        
        examplesLabel.text = examples.joined(separator: ", ")
        favoriteButton.isSelected = isFavorite

    }
    
}
