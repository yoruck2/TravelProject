//
//  CityInfoTableViewCell.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit
import Kingfisher
import Cosmos

class CityInfoTableViewCell: UITableViewCell {
    
    @IBOutlet var spotNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var ratingLabel: CosmosView!
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var heartButton: UIButton!
    
    weak var delegate: ViewControllerDelegate?
    var cellRow: Int = 0
    var saveCount: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
        configureRatingLabel()
    }
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        heartButton.isSelected.toggle()
        if heartButton.isSelected == true {
            saveCount += 1
            saveLabel.text = "･ ♥ \((saveCount).formatThirdComma)"
//            heartButton.tintColor = UIColor.red
        } else {
            saveCount -= 1
            saveLabel.text = "･ ♥ \((saveCount).formatThirdComma)"
//            heartButton.tintColor = .white
        }
        
        delegate?.applyData?(row: cellRow)
    }
    
    func configureLayout() {
        spotNameLabel?.font = UIFont.cellLarge
        descriptionLabel?.font = UIFont.cellMedium
        descriptionLabel?.textColor = .darkGray
        saveLabel?.font = UIFont.cellSmall
        saveLabel?.textColor = .gray
        cellImage.layer.cornerRadius = 10
        cellImage.contentMode = .scaleAspectFill
        
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    }
    
    func configureRatingLabel() {
        ratingLabel.backgroundColor = .clear
        ratingLabel.settings.updateOnTouch = false
        ratingLabel.settings.fillMode = .half
        ratingLabel.settings.starSize = 15
        ratingLabel.settings.totalStars = 5
        ratingLabel.settings.starMargin = 0
    }
    
    func configureCell(data: Travel, row: Int) {
        
        cellRow = row
        
        guard let grade = data.grade,
                let save = data.save,
              let like = data.like
        else {
            return
        }
        
        spotNameLabel?.text = data.title
        descriptionLabel.text = data.description
        
        let url = URL(string: data.travel_image ?? "")
        cellImage.kf.setImage(with: url)
        
        saveCount = save
        saveLabel.text = "･ ♥ \(save.formatThirdComma)"
        ratingLabel.rating = grade
        ratingLabel.text = "(\(grade))"
        heartButton.isSelected = like
    }
}
