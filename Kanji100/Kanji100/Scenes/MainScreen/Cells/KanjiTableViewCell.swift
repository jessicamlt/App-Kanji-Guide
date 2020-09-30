//
//  KanjiTableViewCell.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 14/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import UIKit

protocol KanjiTableViewCellDelegate: AnyObject {
    func kanjiAddedToFavorite(kanji: KanjiData)
    func kanjiRemovedFromFavorite(kanji: KanjiData)
}

class KanjiTableViewCell: UITableViewCell {
    @IBOutlet var kanjiLabel: UILabel!
    @IBOutlet var englishMeaningLabel: UILabel!
    @IBOutlet var onyomyReadLabel: UILabel!
    @IBOutlet var kunyomiReadLabel: UILabel!
    @IBOutlet var examplesLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    weak var delegate: KanjiTableViewCellDelegate?
    static let nib = UINib(nibName: "KanjiTableViewCell", bundle: nil)
    static let identifier = "cell"
    var kanji: KanjiData?

    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func makeFavorite(_ sender: UIButton) {
        guard let kanji = kanji else {
            return
        }
        if kanji.isFavorite {
            delegate?.kanjiRemovedFromFavorite(kanji: kanji)
            return
        }
        delegate?.kanjiAddedToFavorite(kanji: kanji)
    }
    
    func fillCell(kanji: KanjiData) {
        self.kanji = kanji
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
        favoriteButton.isSelected = kanji.isFavorite
    }
}


