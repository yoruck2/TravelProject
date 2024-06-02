//
//  PopularCityTableViewCell.swift
//  TravelProject
//
//  Created by dopamint on 6/1/24.
//

import UIKit
import Kingfisher

class PopularCityTableViewCell: UITableViewCell {

    
    @IBOutlet var backView: UIView!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
        configureShadow()
        selectionStyle = .none
    }
    
    // MARK: - 셀 간의 간격 설정 (layoutSubviews - 뷰 라이프 사이클)
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    func configureLayout() {
        backgroundImageView.contentMode = .scaleToFill
        
        cityNameLabel.font = UIFont.ad
        cityNameLabel.textAlignment = .right
        cityNameLabel.textColor = .white

        descriptionLabel.backgroundColor = .black
        descriptionLabel.textColor = .white
        descriptionLabel.alpha = 0.6
        
        backView.layer.cornerRadius = 20
        backView.layer.maskedCorners = [.layerMinXMinYCorner,
                                        .layerMaxXMaxYCorner]
        backView.layer.masksToBounds = true
    }
    
    func configureShadow() {
        
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = .init(width: 5, height: 5)
        contentView.layer.masksToBounds = false
    }
    
    func setUpCellData(data: City) {
        let image = URL(string: data.city_image)
        backgroundImageView.kf.setImage(with: image)
        cityNameLabel.text = "\(data.city_name) | \(data.city_english_name)"
        descriptionLabel.text = data.city_explain
    }
    
}
