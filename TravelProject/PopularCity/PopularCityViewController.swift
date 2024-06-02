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
    var searchedList = CityInfo.city
    
    var filteredList: [City] = [] {
        didSet {
            popularCityTableView.reloadData()
        }
    }
    var categorizedList = CityInfo.city {
        didSet {
            popularCityTableView.reloadData()
        }
    }
    
    var resultList: Set<City> = Set(CityInfo.city)
    
    @IBOutlet var popularCityTableView: UITableView!
    @IBOutlet var filteringSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredList = cityInfoList
        configureTableView()
        configureFilteringSegment()
        configureSearchBar()
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
            categorizedList = cityInfoList
        case 1:
            categorizedList = cityInfoList.filter { $0.domestic_travel == true }
        case 2:
            categorizedList = cityInfoList.filter { $0.domestic_travel == false }
        default:
            return
        }
    }
    
    func configureTableView() {
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        popularCityTableView.rowHeight = 140
        popularCityTableView.separatorStyle = .none
        
        registerCell(to: popularCityTableView, cellId: PopularCityTableViewCell.identifier)
    }
}

extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            resultList = Set(categorizedList).intersection(Set(searchedList))
            return resultList.count
        } else {
            return categorizedList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, 
                                                 for: indexPath) as! PopularCityTableViewCell
        
        if isFiltering {
            cell.setUpCellData(data: Array(resultList)[indexPath.row])
            return cell
        } else {
            cell.setUpCellData(data: categorizedList[indexPath.row])
            return cell
        }
        
    }
}

extension PopularCityViewController: UISearchResultsUpdating {
    
    // MARK: - 서치바 설정
    func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else {
            resultList = Set(categorizedList)
            popularCityTableView.reloadData()
            return
        }
        
        searchedList = categorizedList.filter {
            $0.city_name.lowercased().contains(text)
        }
        popularCityTableView.reloadData()
    
    }
}
