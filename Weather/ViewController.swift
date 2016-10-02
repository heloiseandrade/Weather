//
//  ViewController.swift
//  Weather
//
//  Created by Heloise Andrade on 9/20/16.
//  Copyright © 2016 ___Heloise Andrade___. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,GetWeatherDelegate,CLLocationManagerDelegate {
    
    var weather : GetWeather!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weather = GetWeather(delegate: self)
        getLocation()
       // weather.getTheWeather("Dubai")
        
    }
    
    
    //GetLocation Method
    
    func getLocation(){
        
        guard CLLocationManager.locationServicesEnabled() else{
            
            print("Location services are disabled on your device. In order to use this app, go to " +
                "Settings → Privacy → Location Services and turn location services on.")
            return
        }
        
        let authStatus = CLLocationManager.authorizationStatus()
        
        guard authStatus ==  .authorizedWhenInUse else{
            switch authStatus {
            case .denied , .restricted:
                print("This app is not authorized to use your location. In order to use this app, " +
                    "go to Settings → GeoExample → Location and select the \"While Using " +
                    "the App\" setting.")
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                print("")
            }
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }
    
    //Delegate Methods
    func didGetWeather(_ weather: Weather) {
        print("City you are in \(weather.city)")
        print("Temp \(weather.tempCelsius)")
    }
    
    func didNotGetWeather(_ error: NSError) {
        print("didNotGetWeather error: \(error)")
    }
    
    //Delegate Methods for Location
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager didFailWithError: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        weather.getWeatherByCoordinates(newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
        print("New location \(newLocation)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

