//
//  RestaurantViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    let restaurantList = RestaurantList.restaurantArray
    var filteredList: [Restaurant] = []
    
    
    var selectedCategory: String = "전체" {
        didSet {
            if self.selectedCategory == "전체" {
                filteredList = restaurantList
            } else {
                
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
        filteredList = restaurantList
        
    }
    
    @IBAction func mapButtonTapped(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navigationController?.pushViewController(vc, animated: true)
        
        let backBarButtonItem = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: nil)
        
            self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
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
        
//        if isFiltering {
//            return searchedList.count
//        }
        
        if selectedCategory != "전체" {
            return filteredList.count
        } else {
            return restaurantList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let nonFilteredData = restaurantList[indexPath.row]
//        let data = filteredList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell
        
//        filteredList = restaurantList.filter { $0.category == selectedCategory }
        if selectedCategory == "전체" {
            cell.configureCell(data: restaurantList[indexPath.row])
            return cell
        } else {
            filteredList = filteredList.filter { $0.category == self.selectedCategory }
            cell.configureCell(data: filteredList[indexPath.row])
            if isFiltering {
                
            }
            
            return cell
            
        }
//        
//        if isFiltering {
//            cell.configureCell(data: searchedList[indexPath.row])
//            return cell
//        } else {
//            if selectedCategory == "전체" {
//                cell.configureCell(data: restaurantList[indexPath.row])
//                return cell
//            } else {
//                filteredList = restaurantList.filter({ $0.category == selectedCategory })
//                cell.configureCell(data: filteredList[indexPath.row])
//                return cell
//            }
        
    }
}

// MARK: - pickerView
//extension RestaurantViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return Category.categoryList.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        showCategoryButton.setTitle(Category.categoryList[row], for: .normal)
//    }
//}

extension RestaurantViewController: UISearchResultsUpdating {
    
    // MARK: - 서치바 설정
    func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        // text가 업데이트될 때마다 불리는 메소드
        searchController.searchResultsUpdater = self
    }
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        
            return isActive && isSearchBarHasText
        }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        
//        for item in restaurantList {
//            if item.name.contains(searchBar.text!) || item.category.contains(searchBar.text!) {
//                searchedList.append(item)
//            }
//        }
//        restaurantTableView.reloadData()
//    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text?.lowercased() else {
            filteredList = restaurantList
            restaurantTableView.reloadData()
            return
        }
        if selectedCategory == "전체" {
            filteredList = filteredList.filter {
                $0.name.lowercased().contains(text)
            }
        } else {
            filteredList = filteredList.filter {
                $0.name.lowercased().contains(text)
            }
        }
        
        restaurantTableView.reloadData()
    }
}



// MARK: - 뷰컨 delegate
extension RestaurantViewController: ViewControllerDelegate {
    func dismissViewController(data: String) {
       selectedCategory = data
        restaurantTableView.reloadData()
    }
}
