//
//  PopularCityTableViewCell.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit
import Kingfisher

class PopularCityTableViewCell: UITableViewCell {

    @IBOutlet var spotNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    
    @IBOutlet var gradeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureLayout() {
        spotNameLabel?.font = .boldSystemFont(ofSize: 17)
        descriptionLabel?.font = .systemFont(ofSize: 13)
        descriptionLabel?.textColor = .darkGray
        saveLabel?.font = .boldSystemFont(ofSize: 13)
        saveLabel?.textColor = .gray
        cellImage.layer.cornerRadius = 10

    }
    
    func configureCell(data: Travel) {
        spotNameLabel?.text = data.title
        descriptionLabel.text = data.description
        gradeLabel.text = String(format:"%.1f", data.grade ?? "")

        
        let url = URL(string: data.travel_image ?? "")
        cellImage.kf.setImage(with: url)
        
        
    }
}
