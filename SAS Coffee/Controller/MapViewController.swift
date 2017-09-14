//
//  MapViewController.swift
//  SAS Coffee
//
//  Created by Duy Cao on 9/7/17.
//  Copyright © 2017 Duy Cao. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: KasperViewController, GMSMapViewDelegate{

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var zoomleve = 15.0
    
    @IBOutlet weak var mapView: GMSMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Camera
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        mapView.mapType = .terrain
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.setAllGesturesEnabled(true)
        
    
        
        //Locationmanager, current location
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        
        
        let position = CLLocationCoordinate2D(latitude: 10.8070802, longitude: 106.6839667)
        let marker = GMSMarker(position: position)
        marker.title = "First Marker"
        marker.icon = #imageLiteral(resourceName: "ic_map_marker")
        marker.infoWindowAnchor = CGPoint.init(x: 1.0, y: 1.0)
        marker.snippet = "gERQWRWQ"
        marker.appearAnimation = .pop
        marker.tracksInfoWindowChanges = true

        marker.map = mapView
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let brvc = AppStoryBoard.Map.instance.instantiateViewController(withIdentifier: VCIdentifiers.BranchVC.rawValue)
        brvc.modalTransitionStyle = .crossDissolve
        brvc.modalPresentationStyle = .overCurrentContext
        brvc.modalPresentationCapturesStatusBarAppearance = true
        self.present(brvc, animated: true, completion: nil)
        return true
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView.init()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: Float(zoomleve))
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
