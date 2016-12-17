//
//  WeatherAPIController.swift
//  HeathersWeather
//
//  Created by HSummy on 12/14/16.
//  Copyright © 2016 HSummy. All rights reserved.
//

import Foundation

protocol WeatherAPIControllerProtocol

{
    func didReceiveAPIResults(_ weather: Weather)
}

class WeatherAPIController
{
   var delegate: WeatherAPIControllerProtocol
    private var key = "ed416ac9b64bcc02b2b49a6c9bc3a4ce"
    
   init (delegate: WeatherAPIControllerProtocol)
   {
        self.delegate = delegate
   }
    
    func searchDarkSkyFor(latitude: Double, longitude: Double)
    {
        let urlPath = "https://api.darksky.net/forecast/\(key)/\(latitude),\(longitude)"
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler:
        {
            data, response, error in
            //below 'print' lines of code are for troubleshooting purposes
            print("Task completed")
            if error != nil
            {
            print(error!.localizedDescription)
            }
            if let weatherInDictionary = self.parseJSON(data!)
            {
               // print(weatherInDictionary) - this can clutter up the troubleshooting console.
            let weather = Weather.downloadedWeatherWithJSON(weatherInDictionary)
                //i have 'weatherInDictionary' data. need to create a func in the Weather class to take in 'weatherInDictionary' as an argument and make into objects.
            self.delegate.didReceiveAPIResults(weather)
            }
        })
    
        task.resume()
        
    } //end of func searchDarkSkyFor
    

    func parseJSON(_ locationAndWeather: Data) -> [String: Any]?
    {
        do
            {
                let json = try JSONSerialization.jsonObject(with: locationAndWeather, options: [])
                if let genericDictionary = json as? [String: Any]
                {
                return genericDictionary
                }
                    else
                    {
                    return nil
                    }
            }
                catch let error as NSError
                {
                    print(error)
                    return nil
                }
    }//end of func parseJSON

}//end of class WeatherAPIController
