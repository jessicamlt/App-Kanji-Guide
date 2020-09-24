//
//  PlaceHolderTableViewCell.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 18/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import UIKit

enum PlaceholderCellType {
    case generalList
    case favoriteList
}

class PlaceholderTableViewCell: UITableViewCell {
    @IBOutlet var principalImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    var placeholderCellType: PlaceholderCellType = .generalList
    static let nib = UINib(nibName: "PlaceholderTableViewCell", bundle: nil)
    static let identifier = "placeholderCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCell() {
        switch placeholderCellType {
        case .generalList:
            principalImageView.image = UIImage(named: "Lupa")
            titleLabel.text = "We're sorry"
            messageLabel.text = "We can't find the word that you're looking for..."
        case .favoriteList:
            principalImageView.image = UIImage(named: "lista")
            titleLabel.text = "Favorites List"
            messageLabel.text = "Save you favorite kanji, you will find them collect here!"
        }
    }
}