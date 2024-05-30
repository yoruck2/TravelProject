//
//  TravelingSpotViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/29/24.
//

import UIKit
import Kingfisher
import Cosmos

class CityInfoDetailViewController: UIViewController {
    
    var cityInfoData: Travel? = nil
    var saveCount: Int = 0
    var cellRow: Int = 0
    weak var delegate: ViewControllerDelegate?
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet var saveCountLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewcontroller()
        configureRatingLabel()
    }
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        heartButton.isSelected.toggle()
        if heartButton.isSelected == true {
            saveCount += 1
            saveCountLabel.text = saveCount.formatThirdComma
        } else {
            saveCount -= 1
            saveCountLabel.text = saveCount.formatThirdComma
        }
        
        delegate?.applyData?(row: cellRow, saveCount: saveCount, isSelected: heartButton.isSelected)
    }
    
    func configureRatingLabel() {
        ratingView.backgroundColor = .clear
        ratingView.settings.updateOnTouch = false
        ratingView.settings.fillMode = .precise
        ratingView.settings.starSize = 20
        ratingView.settings.totalStars = 5
        ratingView.settings.starMargin = 0
        ratingView.rating = cityInfoData?.grade ?? 0
        ratingView.text = "(\(cityInfoData?.grade ?? 0))"
    }
    
    func setUpViewcontroller() {
        
        guard let like = cityInfoData?.like else {
            return
        }
        
        let url = URL(string: cityInfoData?.travel_image ?? "")
        cityImageView.kf.setImage(with: url)
        cityNameLabel.text = cityInfoData?.title
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        descriptionLabel.text = cityInfoData?.description
        saveCountLabel.text = cityInfoData?.save?.formatThirdComma
        saveCount = cityInfoData?.save ?? 0
        heartButton.isSelected = like
        
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    }
}
