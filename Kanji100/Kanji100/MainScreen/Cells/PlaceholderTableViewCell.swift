//
//  PlaceHolderTableViewCell.swift
//  Kanji100
//
//  Created by Jéssica Trindade on 18/09/20.
//  Copyright © 2020 Jéssica Trindade. All rights reserved.
//

import UIKit

class PlaceholderTableViewCell: UITableViewCell {
    
    static let nib = UINib(nibName: "PlaceholderTableViewCell", bundle: nil)
    static let identifier = "placeholderCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
