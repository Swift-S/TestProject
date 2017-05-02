//
//  ViewController.swift
//  Test
//
//  Created by i Daliri on 4/29/17.
//  Copyright © 2017 i Daliri. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces




class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var test: UILabel!
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet weak var accptBttn: UIButton!
    var locationManager = CLLocationManager()
    //    var locationSelected = Location.sta
    var mymarker = GMSMarker()
    var mapGesture = false
    var myView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    
    //    var southWest = CLLocationCoordinate2DMake(35.7828,51.4606)
    //    var northEast = CLLocationCoordinate2DMake(35.6224,51.3254)
    //    var bounds = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        var visibleRegion : GMSVisibleRegion = self.mapView.projection.visibleRegion()
        //        var bounds = GMSCoordinateBounds(coordinate: visibleRegion.nearLeft, coordinate: visibleRegion.nearRight)
        
        //            var southWest = CLLocationCoordinate2DMake(35.7828,51.4606)
        //            var northEast = CLLocationCoordinate2DMake(35.6224,51.3254)
        //            var bounds = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        
        // I'm Here...
        //        var latitude: CLLocationDegrees = 35.7667
        //        var longitude: CLLocationDegrees = 51.4422
        //
        
        test.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "map-marker"))
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
//        let currentZoom = CGFloat(mapView.camera.zoom)
        
//        let camera = GMSCameraPosition.camera(withLatitude: 35.7667, longitude: 51.4422, zoom: Float(currentZoom))
        let camera = GMSCameraPosition.camera(withLatitude: 35.7667, longitude: 51.4422, zoom: 60)

        self.mapView.camera = camera
        self.mapView.delegate = self
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        self.mapView.settings.compassButton = true
        self.mapView.settings.zoomGestures = true
        self.mapView.settings.indoorPicker = true     //Floor picker
        self.mapView.settings.tiltGestures = false
        
        //        self.mapView.settings.setAllGesturesEnabled(true)
        //        self.mapView.settings.accessibilityElementsHidden = false
        
        self.mapView.setMinZoom(10, maxZoom: 120)
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false // NO for obj-c and false for swift
        
        //        self.createMarker(titleMarker: "okokok", iconMarker:  UIImage(named: "map-marker")! , latitude: 35.7667, longitude: 51.4422)
        
        
        //        self.view.addSubview(myView)
        //        self.myView.addSubview(test)
        self.view.bringSubview(toFront: test)
        self.view.bringSubview(toFront: accptBttn)
        print(mapView.camera.target)
        
        //        self.perform(#selector(zoom), with: nil, afterDelay: 4.0)
        
        
    }
    

    
    func zoom() {
        
        CATransaction.begin()
        CATransaction.setValue(1, forKey: kCATransactionAnimationDuration)
        
        // It will animate your camera to the specified lat and long
        let camera = GMSCameraPosition.camera(withLatitude: 28.6139, longitude: 77.2090, zoom: 15)
        mapView!.animate(to: camera)
        
        CATransaction.commit()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("123")
    }
    
    func someAction(_ sender:UITapGestureRecognizer){
        self.mapGesture = true
        if self.mapGesture == true {
            let point: CGPoint = mapView.center
            let coor: CLLocationCoordinate2D = mapView.projection.coordinate(for: point)
            print("ineeeeeeeeeeeee: \(coor)")
        }
    }
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        let point: CGPoint = mapView.center
    //
    //        let coor: CLLocationCoordinate2D = mapView.projection.coordinate(for: point)
    //
    //        self.mapGesture = true
    //        print("error to get location: \(coor)")
    //    }
    
    @IBAction func accptTapped(_ sender: Any) {
        
        let point: CGPoint = mapView.center
        
        let coor: CLLocationCoordinate2D = mapView.projection.coordinate(for: point)
        
        self.mapGesture = true
        print("error to get location: \(coor)")
        
    }
    
    
    func createMarker (titleMarker: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = title
        //        marker.icon = iconMarker
        marker.map = mapView
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error to get location: \(error)")
    }
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        let location = location.last
    //    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        mapView.isMyLocationEnabled = true
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapView.isMyLocationEnabled = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}




