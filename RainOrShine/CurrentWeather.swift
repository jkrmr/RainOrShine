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
    if _date == nil { return "" }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .long
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
      completed(resp)
    }
  }
}
