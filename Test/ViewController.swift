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




class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate,UISearchBarDelegate, LocateOnTheMap, GMSAutocompleteFetcherDelegate {
    
    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var test: UIImageView!         //MarkerImgView
    @IBOutlet weak var accptBttn: UIButton!
    
    var locationManager = CLLocationManager()
    var googleMapsView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.searchBarSetup()
    }
    
    @IBAction func accptTapped(_ sender: Any) {
        
        let point: CGPoint = mapView.center
        let coor: CLLocationCoordinate2D = mapView.projection.coordinate(for: point)
        print("it's my location: \(coor)")
    }
    
    @IBAction func searchWithAddress(_ sender: Any) {
        
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.present(searchController, animated:true, completion: nil)
    }
    
    
    /**
     Locate map with longitude and longitude after search location on UISearchBar
     
     - parameter lon:   longitude location
     - parameter lat:   latitude location
     - parameter title: title of address location
     */
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        
        
        DispatchQueue.main.async { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            self.googleMapsView.camera = camera
            marker.title = "Address : \(title)"
            marker.map = self.googleMapsView
        }
    }
    
    
    /**
     Searchbar when text change
     
     - parameter searchBar:  searchbar UI
     - parameter searchText: searchtext description
     */
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let placeClient = GMSPlacesClient()
        
        
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)  {(results, error: Error?) -> Void in
            // NSError myerr = Error;
            print("Error @%",Error.self)
            
            self.resultsArray.removeAll()
            if results == nil {
                return
            }
            
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    self.resultsArray.append(result.attributedFullText.string)
                }
            }
            
            self.searchResultController.reloadDataWithArray(self.resultsArray)
            
        }
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
    }
    
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        //self.resultsArray.count + 1
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }
    
    func setupView() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
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
        self.mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
        self.mapView.bringSubview(toFront: test)
        self.view.bringSubview(toFront: mapView)
        //        self.view.bringSubview(toFront: test)
        self.view.bringSubview(toFront: accptBttn)
        print(mapView.camera.target)
        
        self.searchBarButton.accessibilityIdentifier = "Search"
    }
    
    func searchBarSetup() {
        self.googleMapsView = GMSMapView(frame: self.mapView.frame)
        self.view.addSubview(self.mapView)
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
    }
}
