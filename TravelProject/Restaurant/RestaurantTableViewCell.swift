//
//  RestaurantTableViewCell.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewCell: UITableViewCell {

    var heartSelected: Bool = false
    
    @IBOutlet var restaurantImage: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contactLabel: UILabel!
    @IBOutlet var adressLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var categoryLabel: UIButton!
    @IBOutlet var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
        setUpHeartButton()
        print("awake cell")
        
    }
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        heartSelected.toggle()
    }
    
    func setUpHeartButton() {
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.imagePadding = 8
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        heartButton.tintColor = .red
        heartButton.configuration = buttonConfiguration
    }
    
    func configureLayout() {
        nameLabel?.font = UIFont.cellLarge
        contactLabel?.font = UIFont.cellSmall
        contactLabel?.textColor = .darkGray
        adressLabel?.font = UIFont.cellSmall
        priceLabel.font = UIFont.cellMedium
        restaurantImage.layer.cornerRadius = 15
        categoryLabel.layer.cornerRadius = 16
        categoryLabel.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func configureCell(data: Restaurant) {
        nameLabel?.text = data.name
        contactLabel.text = data.phoneNumber
        adressLabel.text = data.address
        priceLabel.text = data.price.formatted() + "원"
        categoryLabel.setTitle(data.category, for: .normal)
        categoryLabel.backgroundColor = Category(rawValue: data.category)?.categoryColor()
        
        let url = URL(string: data.image)
        restaurantImage.kf.setImage(with: url)
        
        
    }

}
