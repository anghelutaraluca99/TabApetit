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
import GooglePlaces
import GooglePlacePicker

class NewDebateController : UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {
    
    var googleMapsView = GMSMapView()
    var locationManager = CLLocationManager()
//    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearchAddress))
        
        initGoogleMaps()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
 //       createDatePicker()
    }
    
//    func createDatePicker() {
//        datePicker.datePickerMode = .dateAndTime
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        let setDateButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(handleDatePick))
//        toolbar.setItems([setDateButton], animated: true)
//        dateTextField.inputAccessoryView = toolbar
//        dateTextField.inputView = datePicker
//    }
//    
//    func handleDatePick() {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .short
//        dateTextField.text = "\(datePicker.date)"
//        self.view.endEditing(true)
//    }
    
    func initGoogleMaps() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        googleMapsView = mapView
        self.googleMapsView.delegate = self
        self.googleMapsView.isMyLocationEnabled = true
        self.googleMapsView.settings.myLocationButton = true
        self.googleMapsView.camera = camera
        view = googleMapsView
       
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    //GMSAutocompleteViewControlerDelegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        let marker = GMSMarker(position: position)
        marker.map = googleMapsView
        marker.title = "Your Meeting Location"
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16)
        self.googleMapsView.camera = camera
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error )
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func openSearchAddress() {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil )
    }
    //GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMapsView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.googleMapsView.isMyLocationEnabled = true
        if(gesture){
            mapView.selectedMarker = nil
        }
    }
    //CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 16)
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    
    func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //      DESIGNS:
    
}
