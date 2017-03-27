//
//  CurrentWeather.swift
//  RainOrShine
//
//  Created by Jake Romer on 3/27/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

class CurrentWeather {
  var _cityName: String!
  var cityName: String {
    if _cityName == nil { return "" }
    return _cityName
  }
  
  var _date: String!
  var date: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    let currentDate = dateFormatter.string(from: Date())
    return "Today, \(currentDate)"
  }
  
  var _weatherType: String!
  var weatherType: String {
    if _weatherType == nil { return "" }
    return _weatherType
  }
  
  var _currentTemp: Double!
  var currentTemp: Double {
    if _currentTemp == nil { return 0 }
    return _currentTemp
  }

  func downloadWeatherDetails(completed: @escaping WeatherAPI.DownloadComplete) {
    let currentWeatherURL = URL(string: WeatherAPI.queryURL())!
    Alamofire.request(currentWeatherURL).responseJSON { (resp) in
      if let dict = resp.result.value as? [String: AnyObject],
        let cityName = dict["name"] as? String,
        let weather = dict["weather"] as? [(AnyObject)],
        let short = weather.first as? [String: AnyObject],
        let weatherType = short["description"] as? String,
        let main = dict["main"] as? [String: AnyObject],
        let kelvinTemp = main["temp"] as? Double {

        self._cityName = cityName.capitalized
        self._weatherType = weatherType

        let fahrenheitTemp = kelvinTemp * (9.0/5.0) - 459.67
        self._currentTemp = Double(round(10 * fahrenheitTemp)/10)

        completed(self)
      }
      else {
        print("Error: API query was not successful.")
        completed(nil)
      }
    }
  }
}
