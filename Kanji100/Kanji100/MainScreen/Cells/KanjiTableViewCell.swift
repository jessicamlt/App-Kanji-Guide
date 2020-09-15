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
    
    var kanji: Kanji!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCell() {
        kanjiLabel.text = kanji.kanji
        englishMeaningLabel.text = kanji.englishMeanings?.joined(separator: ", ")
        onyomyReadLabel.text = kanji.onyomy?.joined(separator: " / ")
        kunyomiReadLabel.text = kanji.kunyomi?.joined(separator: " / ")
    }
    
}
