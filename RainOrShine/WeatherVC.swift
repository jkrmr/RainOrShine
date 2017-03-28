//
//  WeatherVC.swift
//  RainOrShine
//
//  Created by Jake Romer on 3/26/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var weatherImage: UIImageView!
  @IBOutlet weak var weatherDescription: UILabel!
  @IBOutlet weak var tableView: UITableView!

  var currentWeather: CurrentWeather?
//  var weatherForecasts: [WeatherForecasts]?

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    CurrentWeather.fetchFromAPI { (currentWeather) in
      guard let currentWeather = currentWeather else { return }
      self.currentWeather = currentWeather
      self.temperatureLabel.text = "\(currentWeather.currentTemp)º"
      self.locationLabel.text = currentWeather.cityName
      self.weatherDescription.text = currentWeather.weatherType
    }
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
}

