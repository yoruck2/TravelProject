//
//  PopularCityTableViewCell.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit
import Kingfisher
import Cosmos

class PopularCityTableViewCell: UITableViewCell {
    
//    static let identifier = "PopularCityTableViewCell"

    @IBOutlet var spotNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var ratingLabel: CosmosView!
    @IBOutlet var gradeLabel: UILabel!
    
    @IBOutlet var cellImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        spotNameLabel?.font = .boldSystemFont(ofSize: 17)
        descriptionLabel?.font = .systemFont(ofSize: 15)
        descriptionLabel?.textColor = .darkGray
        saveLabel?.font = .boldSystemFont(ofSize: 13)
        saveLabel?.textColor = .gray
        cellImage.layer.cornerRadius = 10
        cellImage.contentMode = .scaleAspectFill
        
        ratingLabel.backgroundColor = .clear
        ratingLabel.settings.updateOnTouch = false
        ratingLabel.settings.fillMode = .half
        ratingLabel.settings.starSize = 15
        ratingLabel.settings.totalStars = 5
        ratingLabel.settings.starMargin = 0
        
        
    }
    
    func configureCell(data: Travel) {
        
        guard let grade = data.grade, let save = data.save else {
            return
        }
        
        spotNameLabel?.text = data.title
        descriptionLabel.text = data.description

        let url = URL(string: data.travel_image ?? "")
        cellImage.kf.setImage(with: url)
        
        saveLabel.text = "･ ♥ \(save.formatThirdComma)"
        ratingLabel.rating = grade
        ratingLabel.text = "(\(grade))"
        
    }
}
