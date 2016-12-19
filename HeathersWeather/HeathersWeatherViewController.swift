//
//  HeathersWeatherViewController.swift
//  HeathersWeather
//
//  Created by HSummy on 12/13/16.
//  Copyright © 2016 HSummy. All rights reserved.
//

import UIKit
//import MapKit
//import CoreLocation

class HeathersWeatherViewController: UIViewController, WeatherAPIControllerProtocol
{
    @IBOutlet weak var TodaysTempLabel: UILabel!
    @IBOutlet weak var FeelsLikeLabel: UILabel!
   // @IBOutlet weak var LocationTextField: MKMapView!
    @IBOutlet weak var ActivityTVCell: UITableViewCell!
  


    
//    @IBAction func WhereTo(_ sender: UIButton) {
//        
//        }
    
    var api: WeatherAPIController!
    var weatherInfo = Weather()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
 //       Weather = weatherInfo.downloadedWeatherWithJSON()
        
        api = WeatherAPIController(delegate: self)
        api.searchDarkSkyFor(latitude: 27.77006, longitude: -82.63642)
        //let todayTempLabel.text = "hi"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
      
    }

    
//MARK: - UITableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

      let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTVCell", for: indexPath)
        //let weatherInfo = ActivityTVCell[IndexPath.row]
      //  self.ActivityTVCell.textLabel = String(weatherInfo.apparentTemperatureMax)
        return cell
    }
    func setLabels(weather: Weather)
    {
        self.TodaysTempLabel.text = String(weather.temperatureMax)
        self.FeelsLikeLabel.text = String(weather.apparentTemperatureMax)
      // self.moonPhase.text = String(weather.moonPhase)
    }


//MARK: Model Class - Weather
    
    func didReceiveAPIResults(_ weatherInfo: Weather)
    {
        let queue = DispatchQueue.main
        queue.async
            {
            Weather.current = weatherInfo
            //self.weatherInfo = Weather.downloadedWeatherWithJSON(weatherInfo)
            //self.tableView.reloadData()
            self.setLabels(weather: weatherInfo)

             //   self.heathersWeatherViewController.reloadData()


                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        
    }

}
