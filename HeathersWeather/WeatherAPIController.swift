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
    func didReceiveAPIResults(_ results: [Any])
}

class WeatherAPIControllerProtocol ()
{
   var delegate: WeatherAPIControllerProtocol
    
   init(delegate: WeatherAPIControllerProtocol)
   {
        self.delegate = delegate
    }
    
    if let results = dictionary["results"] as? [Any]
    {
        self.delegate.didReceiveAPIResults(results)
    }
    


        func parseJSON(_ data: Data) -> [String: Any]?
        {
            do
            {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = json as? [String: Any]
                {
                return dictionary
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

}//end of class APIController
