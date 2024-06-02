//
//  CityInfoViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit

class CityInfoViewController: UIViewController {
    
    var popularCityList = TravelInfo.travel
    
    @IBOutlet var cityInfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuretableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        cityInfoTableView.reloadData()
    }
    
    func configuretableView() {
        cityInfoTableView.rowHeight = UITableView.automaticDimension
        cityInfoTableView.delegate = self
        cityInfoTableView.dataSource = self
        registerCell(to: cityInfoTableView, cellId: CityInfoTableViewCell.identifier)
        registerCell(to: cityInfoTableView, cellId: AdTableViewCell.identifier)
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
            let vc = sb.instantiateViewController(withIdentifier: AdViewController.identifier) as! AdViewController
            vc.titleString = data.title
            self.navigationController?.modalPresentationStyle = .fullScreen
            present(vc, animated: true)

        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: CityInfoDetailViewController.identifier) as! CityInfoDetailViewController
            
            vc.cityInfoData = data
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = popularCityList[indexPath.row]
        
        print(popularCityList[indexPath.row].like ?? "광고")
        
        if data.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, 
                                                     for: indexPath) as! AdTableViewCell
            cell.configureCell(data: data)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CityInfoTableViewCell.identifier, 
                                                     for: indexPath) as! CityInfoTableViewCell
            cell.configureCell(data: data, row: indexPath.row)
            return cell
        }
    }
}

extension CityInfoViewController: ViewControllerDelegate {
    func applyData(row: Int, saveCount: Int, isSelected: Bool) {
        popularCityList[row].save = saveCount
        popularCityList[row].like = isSelected
        print("어쨰서?")
        print(#function)
        cityInfoTableView.reloadData()
    }
}
