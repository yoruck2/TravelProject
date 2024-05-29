//
//  TravelingSpotViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/29/24.
//

import UIKit

class TravelingSpotViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var backButton: UIButton!
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    func configureViewController() {
        view.backgroundColor = .white
        titleLabel?.text = titleString
        titleLabel?.font = .systemFont(ofSize: 50, weight: .semibold)
        titleLabel?.textColor = .black
        navigationItem.title = titleString
        
        if titleString == "광고 화면" {
            backButton?.isHidden = true
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
