//
//  RestaurantViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit

protocol ViewControllerDelegate: AnyObject {
    func dismissViewController(data: String)
}

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let category = ["전체", "한식", "카페", "중식", "분식", "일식", "양식", "경양식"]
    var selectedCategory: String = "전체"
    
    let restaurantList = RestaurantList().restaurantArray
    var filteredList: [Restaurant] = []
    
    @IBOutlet var showCategoryButton: UIButton!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var restaurantTableView: UITableView!
    @IBOutlet var favoriteButton: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        filteredList = restaurantList
    }
    
    @IBAction func showCategoryButtonTapped(_ sender: Any) {
        
        guard let categoryVC = storyboard?.instantiateViewController(withIdentifier: "categoryVC") as? CategoryPickerViewController else { return }
        if let sheet = categoryVC.sheetPresentationController {
            sheet.detents = [ .custom(resolver: { context in
                return 300
            })
            ]
        }
        categoryVC.delegate = self
        present(categoryVC, animated: true)
    }
    
    func configureTableView() {
        
        restaurantTableView.rowHeight = 200
        
        searchBar.delegate = self
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        
        registerCell(id: "RestaurantTableViewCell")
        
//        let searchController = UISearchController()
//        self.navigationItem.searchController = searchController
    }
    
    func registerCell(id: String) {
        let nib = UINib(nibName: id, bundle: nil)
        restaurantTableView.register(nib, forCellReuseIdentifier: id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCategory != "전체" {
            filteredList = restaurantList.filter({ $0.category == selectedCategory })
            return filteredList.count
        }
        return restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let nonFilteredData = restaurantList[indexPath.row]
//        
//        let data = filteredList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        if isFiltering {
            cell.configureCell(data: filteredList[indexPath.row])
            return cell
        } else {
            if selectedCategory == "전체" {
                cell.configureCell(data: restaurantList[indexPath.row])
                return cell
            } else {
                filteredList = restaurantList.filter({ $0.category == selectedCategory })
                cell.configureCell(data: filteredList[indexPath.row])
                return cell
            }
        }
    }
}


extension RestaurantViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showCategoryButton.setTitle(category[row], for: .normal)
    }
}

extension RestaurantViewController: UISearchResultsUpdating {
    
    private var isFiltering: Bool {
            let searchController = self.navigationItem.searchController
            let isActive = searchController?.isActive ?? false
            let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
            
            return isActive && isSearchBarHasText
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        var searchList: [Restaurant] = []
        
        for item in restaurantList {
            if item.name.contains(searchBar.text!) || item.category.contains(searchBar.text!) {
                searchList.append(item)
            }
        }
        filteredList = searchList
        restaurantTableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        filteredList = filteredList.filter {
            $0.name.lowercased().contains(text)
        }
        restaurantTableView.reloadData()
    }
}



extension RestaurantViewController: ViewControllerDelegate {
    func dismissViewController(data: String) {
       selectedCategory = data
        restaurantTableView.reloadData()
    }
}
