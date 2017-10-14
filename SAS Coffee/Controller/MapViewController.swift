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
    
    
    var branches : [BranchModel] = [BranchModel].init()
    
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

        
        self.getBranch()
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBranch(){
        self.view.startLoading(loadingView: GlobalUtils.getNVIndicatorView(color: Style.colorPrimary, type: .ballPulse), logo: #imageLiteral(resourceName: "logo.png"), tag: nil)
        RequestService.GET_all_branch(complete: {
            data -> Void in
            let response = data as! [String : Any]
            if response["statuskey"] as! Bool{
                self.branches = DataService.parseBranchList(response: response["branchList"] as! [[String:Any]])
                DispatchQueue.global().async {
                    for item in self.branches{
                        self.addMarker(branch: item)
                    }
                    DispatchQueue.main.async {
                        self.view.stopLoading(loadingViewTag: nil)
                    }
                    
                }
            }else{
                self.view.stopLoading(loadingViewTag: nil)
            }
        })
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
    //func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
     //   let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 36))
      //  label.text = marker.title
        //label.textColor = Style.colorPrimary
        //return label
    //}
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        self.showBranchDetail(branch: marker.userData as! BranchModel)
    }
    
    func showBranchDetail(branch : BranchModel){
        let brvc = AppStoryBoard.Map.instance.instantiateViewController(withIdentifier: VCIdentifiers.BranchVC.rawValue) as! BranchDetailController
        brvc.modalTransitionStyle = .crossDissolve
        brvc.modalPresentationStyle = .overCurrentContext
        brvc.modalPresentationCapturesStatusBarAppearance = true
        brvc.branch = branch
        self.present(brvc, animated: true, completion: nil)
    }
    
    func addMarker(branch : BranchModel){
        let position = CLLocationCoordinate2D(latitude: branch.latitude, longitude: branch.longitude)
        let marker = GMSMarker(position: position)
        marker.title = branch.name
        marker.icon = #imageLiteral(resourceName: "ic_map_marker").changeTint(color: UIColor.red)
        marker.userData = branch
        marker.infoWindowAnchor = CGPoint.init(x: 0.5, y: 0)
        marker.snippet = branch.address
        marker.appearAnimation = .pop
        marker.tracksInfoWindowChanges = true
        marker.map = self.mapView
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
