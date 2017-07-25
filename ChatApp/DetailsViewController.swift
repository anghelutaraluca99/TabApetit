//
//  DetailsViewController.swift
//  ChatApp
//
//  Created by Raluca Angheluta on 24/07/2017.
//  Copyright © 2017 Raluca Angheluta. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailsViewController: UIViewController {

    var placeLat = CLLocationDegrees()
    var placeLong = CLLocationDegrees()
    var time = String()
    var date = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        
        let camera = GMSCameraPosition.camera(withLatitude: placeLat, longitude: placeLong, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: placeLat, longitude: placeLong)
        marker.title = "Reservation Here"
        marker.snippet = "At \(date) - \(time)"
        marker.map = mapView
        view = mapView
    }
    
    func handleBack() {
        self.dismiss(animated: true, completion: nil)
    }

}
