//
//  CityInfoViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit

class CityInfoViewController: UIViewController {
    
    let popularCityList = TravelInfo.travel
    
    @IBOutlet var cityInfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuretableView()
    }
    
    func configuretableView() {
        cityInfoTableView.rowHeight = UITableView.automaticDimension
        cityInfoTableView.delegate = self
        cityInfoTableView.dataSource = self
        registerCell(id: CityInfoTableViewCell.identifier)
        registerCell(id: AdTableViewCell.identifier)
    }
    
    func registerCell(id: String) {
        let nib = UINib(nibName: id, bundle: nil)
        cityInfoTableView.register(nib, forCellReuseIdentifier: id)
    }
}

extension CityInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        popularCityList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = popularCityList[indexPath.row]
        
        if data.ad {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: TravelingSpotViewController.identifier) as! TravelingSpotViewController
            vc.titleString = "광고 화면"
            navigationController?.pushViewController(vc, animated: true)
     
        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: TravelingSpotViewController.identifier) as! TravelingSpotViewController
            vc.titleString = "관광지 화면"
            self.navigationController?.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = popularCityList[indexPath.row]
        
        if data.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            cell.configureCell(data: data)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CityInfoTableViewCell.identifier, for: indexPath) as! CityInfoTableViewCell
            cell.configureCell(data: data, row: indexPath.row)
            return cell
        }
    }
}

extension CityInfoViewController: ViewControllerDelegate {

    func applyData(row: Int) {
        cityInfoTableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
}
