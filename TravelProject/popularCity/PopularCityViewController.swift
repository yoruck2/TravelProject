//
//  PopularCityViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit

class PopularCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let popularCityList = TravelInfo().travel
    
    @IBOutlet var popularCityTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularCityTableView.rowHeight = 150
        
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        
        let nib = UINib(nibName: "PopularCityTableViewCell", bundle: nil)
        popularCityTableView.register(nib, forCellReuseIdentifier: "PopularCityTableViewCell")
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        popularCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCityTableViewCell", for: indexPath) as! PopularCityTableViewCell
        let data = popularCityList[indexPath.row]
        
        cell.configureCell(data: data)

        return cell
    }

}
