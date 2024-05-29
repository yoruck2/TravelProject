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
        configuretableView()
    }
    
    func configuretableView() {
        popularCityTableView.rowHeight = UITableView.automaticDimension
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = popularCityList[indexPath.row]
        
        if data.ad {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "TravelingSpotViewController") as! TravelingSpotViewController
            vc.titleString = "광고 화면"
            navigationController?.pushViewController(vc, animated: true)
     
        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "TravelingSpotViewController") as! TravelingSpotViewController
            vc.titleString = "관광지 화면"
            self.navigationController?.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = popularCityList[indexPath.row]
        
        if data.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
            cell.configureCell(data: data)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCityTableViewCell", for: indexPath) as! PopularCityTableViewCell
            cell.configureCell(data: data, row: indexPath.row)
            return cell
        }
    }
}

extension PopularCityViewController: ViewControllerDelegate {

    func applyData(row: Int) {
        popularCityTableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
}
