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

  static func currentWeatherURL(lat: String? = nil, lon: String? = nil) -> String {
    if let lat = lat, let lon = lon {
      return "\(BASE_URL)/weather?lat=\(lat)&lon=\(lon)&APPID=\(APP_ID)"
    } else {
      return "\(BASE_URL)/weather?q=seattle&APPID=\(APP_ID)"
    }
  }

  static func forecastURL(lat: String? = nil, lon: String? = nil) -> String {
    if let lat = lat, let lon = lon {
      return "\(BASE_URL)/forecast?lat=\(lat)&lon=\(lon)&APPID=\(APP_ID)"
    } else {
      return "\(BASE_URL)/forecast?q=seattle&APPID=\(APP_ID)"
    }
  }

  static func toFahrenheit(from kelvinTemp: Double) -> Double {
    let fahrenheitTemp = kelvinTemp * (9.0/5.0) - 459.67
    let roundedTemp = Double(round(10 * fahrenheitTemp)/10)
    return roundedTemp
  }

  typealias CurrentComplete = (CurrentWeather?) -> ()
  typealias ForecastComplete = ([CurrentWeather]?) -> ()
}
