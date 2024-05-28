//
//  RestaurantTableViewCell.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var restaurantImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contactLabel: UILabel!
    @IBOutlet var adressLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var categoryLabel: UIButton!
    @IBOutlet var hearrButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
        
    }
    
    func configureLayout() {
        nameLabel?.font = .boldSystemFont(ofSize: 17)
        contactLabel?.font = .systemFont(ofSize: 13)
        contactLabel?.textColor = .darkGray
        adressLabel?.font = .boldSystemFont(ofSize: 13)
        restaurantImage.layer.cornerRadius = 15
        
        categoryLabel.layer.cornerRadius = 16
        categoryLabel.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.7294117647, blue: 0.9764705882, alpha: 1)
        categoryLabel.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func configureCell(data: Restaurant) {
        nameLabel?.text = data.name
        contactLabel.text = data.phoneNumber
        adressLabel.text = data.address
        priceLabel.text = data.price.formatted() + "원"
        categoryLabel.setTitle(data.category, for: .normal)
        
        let url = URL(string: data.image)
        restaurantImage.kf.setImage(with: url)
        
        
    }

}
