//
//  AdViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/30/24.
//

import UIKit

class AdViewController: UIViewController {

    @IBOutlet var adLabel: UILabel!

    @IBOutlet var backButton: UIButton!
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAdViewController()
    }
    
    func configureAdViewController() {
        view.backgroundColor = .white
        adLabel?.text = titleString
        adLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        adLabel?.textColor = .black
        adLabel?.numberOfLines = 0
        navigationItem.title = titleString
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
