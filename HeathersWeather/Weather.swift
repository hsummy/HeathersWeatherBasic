//
//  Weather.swift
//  HeathersWeather
//
//  Created by HSummy on 12/15/16.
//  Copyright © 2016 HSummy. All rights reserved.
//

import Foundation

//protocol Weather
//{
//    //func didReceiveWeatherInfo(Weather)
//}

struct Weather

{

    var temperatureMax: Int!
    var apparentTemperatureMax: Int!
    var windSpeed: Int?
    var precipProbability: Float?
    var precipType: String?
    var moonPhase: Float!
    var nearestStormDistance: Int?
    
    static var current: Weather?
    
    init()
    {
        
    }
    
    init(weatherInDictionary: [String: Any])
    {
        self.temperatureMax = weatherInDictionary["temperatureMax"] as? Int
        self.apparentTemperatureMax = weatherInDictionary["apparentTemperatureMax"] as? Int
        self.windSpeed = weatherInDictionary["windspeed"] as? Int
        self.precipProbability = weatherInDictionary["precipProbability"] as? Float
        self.precipType = weatherInDictionary["precipType"] as? String
        self.moonPhase = weatherInDictionary["moonPhase"] as? Float
        self.nearestStormDistance = weatherInDictionary["nearestStormDistance"] as? Int
      
    }
    
    static func downloadedWeatherWithJSON(_ weatherResults: [String: Any]) -> Weather
    {
        var weatherInfo = Weather()
        if let daily = weatherResults["daily"] as? [String: Any]
            {
                if let data = daily["data"] as? [[String:Any]]
                {
                for pieceOfData in data
                    {
                        weatherInfo.temperatureMax = Int(pieceOfData["temperatureMax"] as! Double)
                        weatherInfo.apparentTemperatureMax = Int(pieceOfData["apparentTemperatureMax"] as! Double)
                        weatherInfo.windSpeed = Int(pieceOfData["windSpeed"] as! Double)
                        weatherInfo.precipProbability = pieceOfData["precipProbability"] as? Float
                        weatherInfo.precipType = pieceOfData["precipType"] as? String
                        weatherInfo.moonPhase = Float(pieceOfData["moonPhase"] as! Double)
                    }
                }
            }
        if let currently = weatherResults["currently"] as? [String: Any]
            {
            weatherInfo.nearestStormDistance = (currently["nearestStormDistance"] as! Int)
            }
            return weatherInfo
        
    }//end of static
    
}//end of struct Weather
