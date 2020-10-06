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
            principalImageView.image = UIImage(systemName: "magnifyingglass")
            titleLabel.text = "We're sorry"
            messageLabel.text = "We can't find the word that you're looking for..."
        case .favoriteList:
            principalImageView.image = UIImage(systemName: "star")
            titleLabel.text = "Favorites List"
            messageLabel.text = "Save you favorite kanji, you will find them collect here!"
        }
    }
}
