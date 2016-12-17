//
//  HeathersWeatherViewController.swift
//  HeathersWeather
//
//  Created by HSummy on 12/13/16.
//  Copyright © 2016 HSummy. All rights reserved.
//

import UIKit

class HeathersWeatherViewController: UIViewController, WeatherAPIControllerProtocol
{
    
    
    var api: WeatherAPIController!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        api = WeatherAPIController(delegate: self)
      //  api.searchDarkSkyFor("latitude")
        
        api.searchDarkSkyFor(latitude: 27.77006, longitude: -82.63642)
        
        
        
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
      
    }
    
    func setLabels(weather: Weather) {
        self.temperatureLabel.text = String(weather.temperatureMax)
        self.apparentTemperatureLabel.text = String(weather.temperatureMax)
    }


//MARK: Model Class - Weather
    
    func didReceiveAPIResults(_ weather: Weather)
    {
        let queue = DispatchQueue.main
        queue.async
            {
                Weather.current = weather
                self.setLabels(weather: weather)
                
               // self.heathersWeatherView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        
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
