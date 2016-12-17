//
//  Weather.swift
//  HeathersWeather
//
//  Created by HSummy on 12/15/16.
//  Copyright © 2016 HSummy. All rights reserved.
//

import Foundation

struct Weather
    //QUESTION: IF ONE OF THE BELOW PIECES OF INFO ARE UNAVAILABLE OR DO NOT APPLY FOR THE WEATHER REQUESTED...HOW DO I ACCOUNT FOR THAT???
{
    //daily has 3 objects: data, summary, icon...if i had to choose, it would be items below UNDER data (daily temp is done 4AM - 4AM on Dark Sky).
    var temperatureMax: Int! //daily - data
    var apparentTemperatureMax: Int! //daily - data
    var windSpeed: Int? //daily - data
    var precipProbability: Float? //daily - data
    var precipType: String? //daily - data
    var moonPhase: Float! //daily - data
    var nearestStormDistance: Int? //currently
    //alerts have 4 objects: description, expires, title, uri...if i had to choose, it would be description.
    //var alerts: String? //alerts - description
    
    static var current: Weather?
    
    init()
    {
        
//        temperatureMax = todayTemp
//        apparentTemperatureMax = goingToFeelLikeTemp
//        self.windSpeed = wind
//        precipProbability = chanceOfRain
//        precipType = rainSleetSnow
//        self.moonPhase = moonPhase
//        self.nearestStormDistance = nearestStormDistance
        //self.alerts = alertDescription
        
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
        //self.alerts = weatherInDictionary["alerts"] as? String
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
