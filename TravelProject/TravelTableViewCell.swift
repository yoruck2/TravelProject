//
//  TravelTableViewCell.swift
//  TravelProject
//
//  Created by dopamint on 5/26/24.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet var travelImage: UIImageView!
    @IBOutlet var mainTitle: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    
    func setUpcell(data: Magazine) {
        travelImage.layer.cornerRadius = 15
        
        setUpTravelImage(data)
        mainTitle.text = data.title
        subTitle.text = data.subtitle
        dateLabel.text = DateFormatter().formatKoreanDate(inputDate: data.date)
    }
    
    func setUpTravelImage(_ data: Magazine) {
        let url = URL(string: data.photo_image)
        DispatchQueue.main.async {
            self.travelImage.kf.setImage(with: url)
        }
    }
}
