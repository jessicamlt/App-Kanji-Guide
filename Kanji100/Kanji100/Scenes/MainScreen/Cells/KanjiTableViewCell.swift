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
    @IBOutlet var kanjiView: UIView!
    @IBOutlet var cellViewAbove: UIView!
    @IBOutlet var cellViewUnder: UIView!
    
    weak var delegate: KanjiTableViewCellDelegate?
    static let nib = UINib(nibName: "KanjiTableViewCell", bundle: nil)
    static let identifier = "cell"
    var kanji: KanjiData?

    override func awakeFromNib() {
        super.awakeFromNib()
        cellSetUp()
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
    
    func cellSetUp() {
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        cellViewUnder.layer.masksToBounds = false
        cellViewUnder.layer.shadowColor = UIColor.black.cgColor
        cellViewUnder.layer.shadowOpacity = 0.4
        cellViewUnder.layer.shadowOffset = .zero
        cellViewUnder.layer.shadowRadius = 5.0
        cellViewUnder.layer.shouldRasterize = true
        cellViewAbove.layer.cornerRadius = 8.0
        cellViewAbove.layer.borderWidth = 1.0
        cellViewAbove.layer.borderColor = UIColor(named: "main")?.cgColor
        kanjiView.layer.cornerRadius = 33.0
        kanjiView.layer.masksToBounds = true
    }
    
    func fillCell(kanji: KanjiData) {
        self.kanji = kanji
        kanjiLabel.text = kanji.kanji
        englishMeaningLabel.text = kanji.englishMeanings.joined(separator: ", ")
        onyomyReadLabel.text = "Onyomi: \(kanji.onyomi.joined(separator: " / "))"
        kunyomiReadLabel.text = "Kunyomi: \(kanji.kunyomi.joined(separator: " / "))"
        
        let examplesCollection = kanji.examples
        var examples: [String] = []
        for word in examplesCollection {
            examples.append(word.examples)
        }
        
        examplesLabel.text = examples.joined(separator: ", ")
        favoriteButton.isSelected = kanji.isFavorite
    }
}
