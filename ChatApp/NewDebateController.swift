//
//  NewDebateController.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 15/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import GoogleMaps

class NewDebateController : UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
////UISearchResultsUpdating
    
    var locationManager: CLLocationManager = CLLocationManager()
    var view2 = UIView()
    var view1 = UIView()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
        
        GMSServices.provideAPIKey("AIzaSyBlIivO8ucSKTEm-episVXecRf1dw-YjRU")
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self as? UISearchBarDelegate
        navigationItem.titleView = searchBar
        searchBar.isHidden = true

        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange textSearched: String)
    {
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    
    func handleSearch() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain,target: self, action: #selector(handleDone))
        searchBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let tableView = UITableView()
        view1 = tableView
        view = view1
        
    }
    
    func handleDone() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))
        view = view2
        searchBar.isHidden = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations.last!
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //let currentLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapView.animate(to: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        view2 = mapView
        view = view2
        manager.stopUpdatingLocation()
    }
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func handleCancel() {
        self.dismiss(animated: true, completion: nil)
        return
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        mapView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapView.isMyLocationEnabled = true
        if(gesture) {
            mapView.selectedMarker = nil
        }
    }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        locationManager.stopUpdatingLocation()
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//    }
    
    
//    
//    let cellId = "cellId"
//    let locationManager = CLLocationManager()
//    
//    let googleMapsApiKey = "AIzaSyDwamxZzHnOBRwDzol8tH"
//    GMSServices.provideApiKey
//    let camera = GMSCameraPosition.camera(withLatitude: 46.229585, longitude: 27.669724, zoom: 10)
//    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
////    let array = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
////    var filteredArray = [String]()
//    var searchController = UISearchController()
//    let resultsController = UITableViewController()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.white
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
//        
//        view.addSubview(mapView)
//        setupMapView()
//        mapView.tintColor = UIColor.gray
//        mapView.isHidden = false
//        
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        
////        searchController = UISearchController(searchResultsController: resultsController)
////        tableView.tableHeaderView = searchController.searchBar
////        searchController.searchResultsUpdater = self
////        resultsController.tableView.delegate = self
////        resultsController.tableView.dataSource = self
//        
//    }
//    
//    
//    func handleCancel() {
//        self.dismiss(animated: true, completion: nil)
//        return
//    }
//    
////    func updateSearchResults(for searchController: UISearchController) {
////        filteredArray = array.filter({ (array : String) -> Bool in
////            if array.contains(searchController.searchBar.text!) {
////                return true
////            } else {
////                return false
////            }
////        })
////        resultsController.tableView.reloadData()
////    }
////    
////    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        if tableView == resultsController.tableView {
////            return filteredArray.count
////        } else {
////            return array.count
////        }
////    }
////    
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
////        if tableView == resultsController.tableView {
////            cell.textLabel?.text = filteredArray[indexPath.row]
////        } else {
////            cell.textLabel?.text = array[indexPath.row]
////        }
////        return cell
////    }
//}
//
//extension NewDebateController {
//    
//    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//            mapView.isMyLocationEnabled = true
//            mapView.settings.myLocationButton = true
//        }
//    }
//    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
//            locationManager.stopUpdatingLocation()
//        }
//    }
//    func setupMapView() {
//        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//    }
}
