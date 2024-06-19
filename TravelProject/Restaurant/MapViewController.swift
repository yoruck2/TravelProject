//
//  MapViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/31/24.
//

import UIKit
import MapKit
import CoreLocation

import SnapKit

class MapViewController: UIViewController {
    
// TODO: 원만들기 왜안될까
    lazy var currentLocationButton = {
        let button = UIButton()
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
        let image = UIImage(systemName: "scope", withConfiguration: imageConfiguration)
        
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.configureShadow()
        return button
    }()
    
    let locationManager = CLLocationManager()
    
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
        configureLayout()
        configureNaviBar()
        
        createAnnotaion()
//        configureMapView()
        restaurantMapView.delegate = self
        locationManager.delegate = self
        currentLocationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
    }
    
    @objc func locationButtonTapped() {
        checkDeviceLocationAutorization()
    }

    func configureLayout() {
        view.addSubview(currentLocationButton)
        
        currentLocationButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.width.height.equalTo(60)
        }
    }
    func configureNaviBar() {
        let categoryButton = UIBarButtonItem(title: "카테고리",
                                             style: .plain,
                                             target: self,
                                             action: #selector(categoryButtonTapped))
        self.navigationItem.rightBarButtonItem = categoryButton
    }
    
    func setRegionToSeSAC() {
        let center = CLLocationCoordinate2D(latitude: 37.517813, 
                                            longitude: 126.886467)
        restaurantMapView.region = MKCoordinateRegion(center: center,
                                                      latitudinalMeters: 300,
                                                      longitudinalMeters: 300)
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

extension MapViewController {
    
    // 현재 기기가 위치서비스 사용가능한지 확인
    func checkDeviceLocationAutorization() {
        
        
        guard CLLocationManager.locationServicesEnabled() else {
            showAlert(message: .servieOff)
            return
        }
        checkCurrentLocationAuthorization()
    }
    
    func checkCurrentLocationAuthorization() {
        var status: CLAuthorizationStatus
        status = locationManager.authorizationStatus
//        if #available(iOS 14.0, *) {
//            status = locationManager.authorizationStatus
//        } else {
//            status = CLLocationManager.authorizationStatus()
//        }

        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("거절했었음")
            showAlert(message: .denied)
            setRegionToSeSAC()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print(status)
        }
    }
    
    func showAlert(message: LocationServieAlertMessage) {
        
        let locationRequestAlert = UIAlertController(title: "위치 정보 이용",
                                                     message: message.showMessage(),
                                                     preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        locationRequestAlert.addAction(cancel)
        locationRequestAlert.addAction(goSetting)
        
        present(locationRequestAlert, animated: true)
    }
}
    
extension MapViewController: CLLocationManagerDelegate {

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
            restaurantMapView.showsUserLocation = true
            
            if restaurantMapView.userTrackingMode == .follow {
                restaurantMapView.userTrackingMode = .none
            }
            restaurantMapView.userTrackingMode = .follow
        }
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAutorization()
    }
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: center, 
                                        latitudinalMeters: 100,
                                        longitudinalMeters: 100)
        restaurantMapView.setRegion(region, animated: true)
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
