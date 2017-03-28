//
//  WeatherForecast.swift
//  RainOrShine
//
//  Created by Jake Romer on 3/27/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

class WeatherForecast {
  var weatherType: String
  var tempMin: Double
  var tempMax: Double
  var date: Int

  var dayOfWeek: String {
    let epochTime = Date(timeIntervalSince1970: Double(date))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: epochTime)
  }

  init(date: Int, weatherType: String, tempMin: Double, tempMax: Double) {
    self.date = date
    self.weatherType = weatherType
    self.tempMin = tempMin
    self.tempMax = tempMax
  }

  init?(attrs: [String: AnyObject]) {
    guard let weatherData = attrs["weather"] as? [(AnyObject)],
      let weather = weatherData.first as? [String: AnyObject],
      let weatherType = weather["main"] as? String,
      let temp = attrs["temp"] as? [String: AnyObject],
      let tempMin = temp["min"] as? Double,
      let tempMax = temp["max"] as? Double,
      let date = attrs["dt"] as? Int
      else { return nil }

    self.date = date
    self.tempMin = WeatherAPI.toFahrenheit(from: tempMin)
    self.tempMax = WeatherAPI.toFahrenheit(from: tempMax)
    self.weatherType = weatherType
  }

  static func create(forecasts: [[String: AnyObject]]) -> [WeatherForecast] {
    var weatherForecasts = [WeatherForecast]()

    for forecast in forecasts {
      if let newForecast = WeatherForecast(attrs: forecast) {
        weatherForecasts.append(newForecast)
      }
    }

    return weatherForecasts
  }

  static func fetchFromAPI(location: WeatherAPI.Coordinates, completed: @escaping WeatherAPI.ForecastComplete) {
    let url = URL(string: WeatherAPI.forecastURL(coordinates: location))!
    Alamofire.request(url).responseJSON { (resp) in
      if let results = resp.result.value as? [String: AnyObject],
        let forecastData = results["list"] as? [[String: AnyObject]] {
        let forecasts = self.create(forecasts: forecastData)
        completed(forecasts)
      } else {
        print("Error: API query was not successful.")
        completed(nil)
      }
    }
  }
}
