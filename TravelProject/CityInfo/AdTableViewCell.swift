//
//  AdTableViewCell.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var adContentLabel: UILabel!
    @IBOutlet var adbadgeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
        adbadgeLabel.layer.cornerRadius = 13
        adbadgeLabel.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    func configureLayout() {
        adContentLabel.textAlignment = .center
        adContentLabel.font = UIFont.ad
        adContentLabel.numberOfLines = 0
        
        adbadgeLabel.text = "AD"
        adbadgeLabel.backgroundColor = .white
        adbadgeLabel.textAlignment = .center
        backgroundColor = UIColor().RandomColor()
        
        self.selectionStyle = .none
    }
    
    func configureCell(data: Travel) {
        adContentLabel.text = data.title
    }
}
