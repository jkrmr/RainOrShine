//
//  WeatherAPI.swift
//  RainOrShine
//
//  Created by Jake Romer on 3/27/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation

struct WeatherAPI {
  private static let BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
  private static let APP_ID = "aa3b36c42f2a9dad5ca5451c29339e7b"

  static func queryURL(lat: String? = nil, lon: String? = nil) -> String {
    if let lat = lat, let lon = lon {
      return "\(BASE_URL)?lat=\(lat)&lon=\(lon)&APPID=\(APP_ID)"
    } else {
      return "\(BASE_URL)?q=seattle&APPID=\(APP_ID)"
    }
  }
}
