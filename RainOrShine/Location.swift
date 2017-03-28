//
//  Location.swift
//  RainOrShine
//
//  Created by Jake Romer on 3/28/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import CoreLocation

class Location {
  static var shared = Location()
  private init() {}

  var lat: Double!
  var lon: Double!

  var currentLocationCoordinates: (lat: Double, lon: Double) {
    return (lat: lat, lon: lon)
  }

  func set(fromLocation location: CLLocation) {
    lat = location.coordinate.latitude
    lon = location.coordinate.longitude
  }
}
