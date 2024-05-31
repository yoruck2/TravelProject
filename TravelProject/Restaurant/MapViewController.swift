//
//  MapViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/31/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let restaurantList = RestaurantList.restaurantArray
    var filteredList = [Restaurant]() {
        didSet {
            self.restaurantMapView.removeAnnotations(self.restaurantMapView.annotations)
            self.createAnnotaion()
        }
    }
    
    @IBOutlet var restaurantMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredList = restaurantList
        restaurantMapView.delegate = self
        configureNaviBar()
        createAnnotaion()
        configureMapView()
        
    }
    
    func configureMapView() {
        let center = CLLocationCoordinate2D(latitude: 37.517813, longitude: 126.886467)
        restaurantMapView.region = MKCoordinateRegion(center: center,
                                                      latitudinalMeters: 1000,
                                                      longitudinalMeters: 1000)
    }
    
    func createAnnotaion() {
        
        for restaurant in filteredList {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude,
                                                           longitude: restaurant.longitude)
            annotation.title = restaurant.name
            annotation.subtitle = restaurant.category
            restaurantMapView.addAnnotation(annotation)
            
        }
    }
    
    func configureNaviBar() {
        let categoryButton = UIBarButtonItem(title: "카테고리", 
                                             style: .plain,
                                             target: self,
                                             action: #selector(categoryButtonTapped))
        self.navigationItem.rightBarButtonItem = categoryButton
    }
    
    @objc
    func categoryButtonTapped() {
        
        let actionSheet = UIAlertController(title: "카테고리 선택", message: "선택한 카테고리만 지도에 보여집니다.", preferredStyle: .actionSheet)
        
        actionSheet.addAction("전체보기", .default) {_ in
            self.filteredList = self.restaurantList
        }
        
        for category in Category.allCases {
            actionSheet.addAction(category.rawValue, .default) {_ in 
                self.filteredList = self.restaurantList.filter { $0.category == category.rawValue }
            }
        }
        
        actionSheet.addAction("취소", .cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    // any(5.6) vs some(5.1)
    func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print(#function)
    }
}
