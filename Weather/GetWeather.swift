//
//  GetWeather.swift
//  Weather
//
//  Created by Heloise Andrade on 9/20/16.
//  Copyright © 2016 ___Heloise Andrade___. All rights reserved.
//

import Foundation

//Setting protocols
protocol GetWeatherDelegate{
    func didGetWeather(_ weather:Weather)
    func didNotGetWeather(_ error:NSError)
}

class GetWeather{
    
    //Set API URl
    fileprivate let openWeatherBaseURl = "http://api.openweathermap.org/data/2.5/weather"
    
    //Set API Key
    fileprivate let openWeatherAPIKEY = "297c1e87e6faf36efb2632fe719545e8"
    
    var delegate :GetWeatherDelegate?
    
    init(delegate:GetWeatherDelegate){
        self.delegate = delegate
    }
    
    func getWeatherByCoordinates(_ latitude:Double , longitude:Double){
         let weatherRequestURL = URL(string: "\(openWeatherBaseURl)?lat=\(latitude)&lon=\(longitude)&appid=\(openWeatherAPIKEY)")
         getWeather(weatherRequestURL!)
    }
    
    
    func getTheWeather(_ city:String){
        
        let weatherRequestURL = URL(string: "\(openWeatherBaseURl)?q=\(city)&appid=\(openWeatherAPIKEY)")
        getWeather(weatherRequestURL!)
    }
    
    //Network call to retrive the weather
    func getWeather(_ weatherRequestURL:URL){
        
        //Set up session.
        let session = URLSession.shared
        
       // let weatherRequestURL = NSURL(string: "\(openWeatherBaseURl)?q=\(city)&appid=\(openWeatherAPIKEY)")
        
        let dataTask =  session.dataTask(with: weatherRequestURL, completionHandler: { (data, response, error) in
            
        
            if let errorValue = error{
                print(errorValue)
            }else{
                do
                {
                    let weather = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
                    
                    print("City selected : \(weather["name"])")
                    let weatherData = Weather(weather:weather)
                    self.delegate?.didGetWeather(weatherData)
                }
                catch let jsonError as NSError {
                    // An error occurred while trying to convert the data into a Swift dictionary.
                   // print("JSON error description: \(jsonError.description)")
                    self.delegate?.didNotGetWeather(jsonError)
                }
            }
            
        }) 
        dataTask.resume()
        
    }
}

