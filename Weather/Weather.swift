//
//  Weather.swift
//  Weather
//
//  Created by Heloise Andrade on 9/21/16.
//  Copyright © 2016 ___Heloise Andrade___. All rights reserved.
//

import Foundation

struct Weather {
    
    let dateAndTime: Date
    
    let city: String
    let country: String
    let longitude: Double
    let latitude: Double
    
    let weatherID: Int
    let mainWeather: String
    let weatherDescription: String
    let weatherIconID: String
    
    
    let windDirection: Double?
    let rainfallInLast3Hours: Double?
    
    fileprivate let temp: Double
    var tempCelsius: Double {
        get {
            return temp - 273.15
        }
    }
    var tempFahrenheit: Double {
        get {
            return (temp - 273.15) * 1.8 + 32
        }
    }
    let humidity: Int
    let pressure: Int
    let cloudCover: Int
    let windSpeed: Double
    
    let sunrise: Date
    let sunset: Date
    
    
    init(weather:[String : AnyObject]){
        
        dateAndTime = Date(timeIntervalSince1970: weather["dt"] as! TimeInterval)
        city = weather["name"] as! String
        
        let coordDict = weather["coord"] as! [String: AnyObject]
        longitude = coordDict["lon"] as! Double
        latitude = coordDict["lat"] as! Double
        
        let weatherDict = weather["weather"]![0] as! [String: AnyObject]
        weatherID = weatherDict["id"] as! Int
        mainWeather = weatherDict["main"] as! String
        weatherDescription = weatherDict["description"] as! String
        weatherIconID = weatherDict["icon"] as! String
        
        let mainDict = weather["main"] as! [String: AnyObject]
        temp = mainDict["temp"] as! Double
        humidity = mainDict["humidity"] as! Int
        pressure = mainDict["pressure"] as! Int
        
        cloudCover = weather["clouds"]!["all"] as! Int
        
        let windDict = weather["wind"] as! [String: AnyObject]
        windSpeed = windDict["speed"] as! Double
        windDirection = windDict["deg"] as? Double
        
        if weather["rain"] != nil {
            let rainDict = weather["rain"] as! [String: AnyObject]
            rainfallInLast3Hours = rainDict["3h"] as? Double
        }
        else {
            rainfallInLast3Hours = nil
        }
        
        let sysDict = weather["sys"] as! [String: AnyObject]
        country = sysDict["country"] as! String
        sunrise = Date(timeIntervalSince1970: sysDict["sunrise"] as! TimeInterval)
        sunset = Date(timeIntervalSince1970:sysDict["sunset"] as! TimeInterval)
        
    }
    
}
