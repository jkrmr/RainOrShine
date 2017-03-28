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
  var cityName: String
  var weatherType: String
  var currentTemp: Double
  var date: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    let currentDate = dateFormatter.string(from: Date())
    return "Today, \(currentDate)"
  }

  init(cityName: String, weatherType: String, currentTemp: Double) {
    self.cityName = cityName
    self.currentTemp = currentTemp
    self.weatherType = weatherType
  }

  static func fetchFromAPI(completed: @escaping WeatherAPI.CurrentComplete) {
    let url = URL(string: WeatherAPI.currentWeatherURL())!
    Alamofire.request(url).responseJSON { (resp) in
      if let dict = resp.result.value as? [String: AnyObject],
        let cityName = dict["name"] as? String,
        let weather = dict["weather"] as? [(AnyObject)],
        let short = weather.first as? [String: AnyObject],
        let weatherType = short["main"] as? String,
        let main = dict["main"] as? [String: AnyObject],
        let temp = main["temp"] as? Double {

        let weather = CurrentWeather(cityName: cityName.capitalized,
                                     weatherType: weatherType,
                                     currentTemp: WeatherAPI.toFahrenheit(from: temp))
        completed(weather)
      }
      else {
        print("Error: API query was not successful.")
        completed(nil)
      }
    }
  }
}
