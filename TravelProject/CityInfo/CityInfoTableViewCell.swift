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
        } else {
            saveCount -= 1
            saveLabel.text = "･ ♥ \((saveCount).formatThirdComma)"
        }
        
        // MARK: - 셀의 변경사항을 뷰컨트롤러가 가진 tableView를 업데이트 시켜주기 위해 델리게이트를 통한 업데이트 할 셀의 row 전달
        // MARK: - 인줄 알았는데 아니었다??!?!?! 주석 처리 해도 테이블뷰 셀에 반영이 된다..
        delegate?.applyData?(row: cellRow, saveCount: saveCount, isSelected: heartButton.isSelected)
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
