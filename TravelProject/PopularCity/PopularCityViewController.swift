//
//  PopularCityViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/30/24.
//
//

import UIKit

class PopularCityViewController: UIViewController {
    
    let cityInfoList = CityInfo.city
    var filteredList: [City] = [] {
        didSet {
            popularCityTableView.reloadData()
        }
    }
    
    @IBOutlet var popularCityTableView: UITableView!
    @IBOutlet var filteringSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredList = cityInfoList
        configureTableView()
        configureFilteringSegment()
    }
    
    func configureFilteringSegment() {
        filteringSegment.setTitle("전체보기", forSegmentAt: 0)
        filteringSegment.setTitle("국내", forSegmentAt: 1)
        filteringSegment.insertSegment(withTitle: "해외", at: 2, animated: true)
        filteringSegment.addTarget(self, action: #selector(filterRestaurant), for: .valueChanged)
    }
    
    @objc
    func filterRestaurant() {
        switch filteringSegment.selectedSegmentIndex {
        case 0:
            filteredList = cityInfoList
        case 1:
            filteredList = cityInfoList.filter { $0.domestic_travel == true}
        case 2:
            filteredList = cityInfoList.filter { $0.domestic_travel == false}
        default:
            return
        }
    }
    
    func configureTableView() {
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        popularCityTableView.rowHeight = 140
        popularCityTableView.separatorStyle = .none
        
        let xib = UINib(nibName: PopularCityTableViewCell.identifier, bundle: nil)
        
        popularCityTableView.register(xib, forCellReuseIdentifier: PopularCityTableViewCell.identifier)
    }
}

extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, 
                                                 for: indexPath) as! PopularCityTableViewCell
        cell.setUpCellData(data: filteredList[indexPath.row])
        return cell
    }
}

