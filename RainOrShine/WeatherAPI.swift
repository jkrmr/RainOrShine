//
//  WeatherAPI.swift
//  RainOrShine
//
//  Created by Jake Romer on 3/27/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation

struct WeatherAPI {
  private static let BASE_URL = "http://api.openweathermap.org/data/2.5"
  private static let APP_ID = "aa3b36c42f2a9dad5ca5451c29339e7b"

  typealias Coordinates = (lat: Double, lon: Double)
  typealias CurrentComplete = (CurrentWeather?) -> ()
  typealias ForecastComplete = ([WeatherForecast]?) -> ()

  static func currentWeatherURL(coordinates: Coordinates? = nil) -> String {
    if let (lat, lon) = coordinates {
      return "\(BASE_URL)/weather?lat=\(lat)&lon=\(lon)&APPID=\(APP_ID)"
    } else {
      return "\(BASE_URL)/weather?q=seattle&APPID=\(APP_ID)"
    }
  }

  static func forecastURL(coordinates: Coordinates? = nil) -> String {
    if let (lat, lon) = coordinates {
      return "\(BASE_URL)/forecast/daily?lat=\(lat)&lon=\(lon)&APPID=\(APP_ID)"
    } else {
      return "\(BASE_URL)/forecast/daily?q=seattle&APPID=\(APP_ID)"
    }
  }

  static func toFahrenheit(from kelvinTemp: Double) -> Double {
    let fahrenheitTemp = kelvinTemp * (9.0/5.0) - 459.67
    let roundedTemp = Double(round(10 * fahrenheitTemp)/10)
    return roundedTemp
  }
}
