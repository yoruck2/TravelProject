//
//  ViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/26/24.
//

import UIKit
import Kingfisher
import SafariServices

class TravelTableViewController: UITableViewController {

    var magazineInfo = MagazineInfo().magazine
    var restaurant = RestaurantList.restaurantArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
    }
}

extension TravelTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineInfo.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        460
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: magazineInfo[indexPath.row].link) else {
            return
        }
        let safariView: SFSafariViewController = SFSafariViewController(url: url)
        self.present(safariView, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath)
            cell.textLabel?.text = "내용을 불러오는데 실패했습니다."
            return cell
        }
        cell.setUpcell(data: magazineInfo[indexPath.row])

        return cell
    }
}
