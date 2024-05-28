//
//  PopularCityViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit

class PopularCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let popularCityList = TravelInfo.travel
    
    @IBOutlet var popularCityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCell()
    }
    
    func configureCell() {
        popularCityTableView.rowHeight = 150
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        registerCell(id: "PopularCityTableViewCell")
        registerCell(id: "AdTableViewCell")
    }
    
    func registerCell(id: String) {
        let nib = UINib(nibName: id, bundle: nil)
        popularCityTableView.register(nib, forCellReuseIdentifier: id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        popularCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = popularCityList[indexPath.row]
        
        if data.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
            cell.configureCell(data: data)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCityTableViewCell", for: indexPath) as! PopularCityTableViewCell
            cell.configureCell(data: data)
            return cell
        }
    }
}
