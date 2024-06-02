//
//  RestaurantViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    let restaurantList = RestaurantList.restaurantArray
    var categorizedList: [Restaurant] = RestaurantList.restaurantArray
    var searchedList: [Restaurant] = RestaurantList.restaurantArray
    var resultList: [Restaurant] = RestaurantList.restaurantArray
    var favoriteList: [Restaurant] = []
    
    
    var selectedCategory: String = "전체" {
        didSet {
            if self.selectedCategory == "전체" {
                categorizedList = restaurantList
            } else {
                categorizedList = restaurantList.filter({ $0.category == selectedCategory })
            }
            self.restaurantTableView.reloadData()
        }
    }
    
    @IBOutlet var showCategoryButton: UIButton!
    @IBOutlet var restaurantTableView: UITableView!
    @IBOutlet var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureSearchBar()
        favoriteButton.layer.cornerRadius = 15
        
    }
    
    // MARK: - 지도보기 버튼 tap
    @IBAction func mapButtonTapped(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navigationController?.pushViewController(vc, animated: true)
        
        let backBarButtonItem = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }

    // MARK: - 카테고리 버튼 tap
    @IBAction func showCategoryButtonTapped(_ sender: Any) {
        
        guard let categoryVC = storyboard?.instantiateViewController(withIdentifier: "categoryVC") as? CategoryPickerViewController else { return }
        if let sheet = categoryVC.sheetPresentationController {
            sheet.detents = [ .custom(resolver: { context in
                return 280
            })
            ]
        }
        categoryVC.delegate = self
        present(categoryVC, animated: true)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            favoriteButton.configuration?.baseForegroundColor = .systemGray4
            favoriteButton.configuration?.baseBackgroundColor = #colorLiteral(red: 0.723005712, green: 0.07351250201, blue: 0, alpha: 1)
        } else {
            favoriteButton.configuration?.baseForegroundColor = .systemBackground
            favoriteButton.configuration?.baseBackgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
        
    }
}


// MARK: - tableView
extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        
        restaurantTableView.rowHeight = 200
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        
        registerCell(id: RestaurantTableViewCell.identifier)
    }
    
    func registerCell(id: String) {
        let nib = UINib(nibName: id, bundle: nil)
        restaurantTableView.register(nib, forCellReuseIdentifier: id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if selectedCategory == "전체" && isFiltering {
            return searchedList.count
        } else if selectedCategory != "전체" && isFiltering {
            return searchedList.count
        } else if selectedCategory == "전체" && !isFiltering {
            return restaurantList.count
        } else {
            return categorizedList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let nonFilteredData = restaurantList[indexPath.row]
        //        let data = filteredList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        if selectedCategory == "전체" && isFiltering {
            cell.configureCell(data: searchedList[indexPath.row])
            return cell
        } else if selectedCategory != "전체" && isFiltering {
            cell.configureCell(data: searchedList[indexPath.row])
            return cell
        } else if selectedCategory == "전체" && !isFiltering {
            cell.configureCell(data: restaurantList[indexPath.row])
            return cell
        } else {
            cell.configureCell(data: categorizedList[indexPath.row])
            return cell
        }
    }
}

extension RestaurantViewController: UISearchResultsUpdating {
    
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
            searchedList = categorizedList
            restaurantTableView.reloadData()
            return
        }
        
        if selectedCategory == "전체" {
            searchedList = restaurantList.filter {
                $0.name.lowercased().contains(text)
            }
        } else {
            searchedList = categorizedList.filter {
                $0.name.lowercased().contains(text)
            }
        }
        restaurantTableView.reloadData()
    }
}


// MARK: - 뷰컨 delegate
extension RestaurantViewController: ViewControllerDelegate {
    func dismissViewController(label: String, color: UIColor) {
        print(#function)
        selectedCategory = label
        if label == "전체" {
            showCategoryButton.setTitle("카테고리", for: .normal)
            showCategoryButton.tintColor = #colorLiteral(red: 0.196, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        } else {
            showCategoryButton.setTitle(label, for: .normal)
            showCategoryButton.tintColor = color
        }
        restaurantTableView.reloadData()
    }
}
