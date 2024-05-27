//
//  RestaurantViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/28/24.
//

import UIKit

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let restaurantList = RestaurantList().restaurantArray
    var filteredList: [Restaurant] = []
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var restaurantTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let left = UIBarButtonItem(title: "한식만", style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.leftBarButtonItem = left
        
        restaurantTableView.rowHeight = 230
        
        searchBar.delegate = self
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        
        let nib = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        restaurantTableView.register(nib, forCellReuseIdentifier: "RestaurantTableViewCell")
        
        filteredList = restaurantList
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        
//        var searchList: [Restaurant] = []
//        
//        for item in restaurantList {
//            if item.name.contains(searchBar.text!) || item.category.contains(searchBar.text!) {
//                searchList.append(item)
//            }
//        }
//    }
    
    @objc
    func leftBarButtonClicked() {
        let filteredList = restaurantList.filter { $0.category == "한식" }
        restaurantTableView.reloadData()
        print(filteredList)
        print(filteredList.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        let data = filteredList[indexPath.row]
        
        cell.configureCell(data: data)

        return cell
    }
}
