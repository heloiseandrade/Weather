//
//  GetWeather.swift
//  Weather
//
//  Created by Heloise Andrade on 9/20/16.
//  Copyright © 2016 ___Heloise Andrade___. All rights reserved.
//

import Foundation

class GetWeather{
    
    //Set API URl
    private let openWeatherBaseURl = "http://api.openweathermap.org/data/2.5/weather"
    
    //Set API Key
    private let openWeatherAPIKEY = "297c1e87e6faf36efb2632fe719545e8"
    
    //Network call to retrive the weather
    func getWeather(city:String){
        
        //Set up session.
        let session = NSURLSession.sharedSession()
        
        let weatherRequestURL = NSURL(string: "\(openWeatherBaseURl)?q=\(city)&appid=\(openWeatherAPIKEY)")
        
        let dataTask = session.dataTaskWithURL(weatherRequestURL){
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            if let error = error{
                print("Error is : \(error)")
            }else{
                print("Data is present")
            }
        }
        
        dataTask.resume()
        
    }
    
}


