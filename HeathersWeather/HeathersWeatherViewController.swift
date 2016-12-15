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
        api.searchDarkSkyFor("")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
      
    }

//MARK: Model Class - API
    func didReceiveAPIResults(_ results: Dictionary<String, Any>)
    {
        let queue = DispatchQueue.main
        queue.async
            {
                self.weatherInfo = Weather.weatherInfoFromDarkSky(results)
                self.heathersWeatherView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
    }
 //MARK: Model Class - Weather
    
    func didReceiveLocationResults(_ results: [Any])
    {

        let queue = DispatchQueue.main
        queue.async
            {

                self.weatherInfo = Weather.weatherInfoFromDarkSky(results)
                self.heathersWeatherView.reloadData()
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
