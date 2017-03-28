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

  var currentWeather: CurrentWeather!
  var weatherForecasts = [WeatherForecast]() {
    didSet { tableView.reloadData() }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    CurrentWeather.fetchFromAPI { (currentWeather) in
      guard let currentWeather = currentWeather else { return }
      self.updateCurrentWeather(currentWeather)
    }

    WeatherForecast.fetchFromAPI { (forecasts) in
      guard let forecasts = forecasts else { return }
      let futureForecasts = Array(forecasts.dropFirst(2))
      self.weatherForecasts = futureForecasts
    }
  }

  func updateCurrentWeather(_ currentWeather: CurrentWeather) {
    self.currentWeather = currentWeather
    self.temperatureLabel.text = "\(currentWeather.currentTemp)º"
    self.locationLabel.text = currentWeather.cityName
    self.weatherDescription.text = currentWeather.weatherType
    self.weatherImage.image = UIImage(named: currentWeather.weatherType)
    self.dateLabel.text = currentWeather.date
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherForecasts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell",
                                             for: indexPath)
    if let cell = cell as? WeatherCell {
      cell.forecast = weatherForecasts[indexPath.row]
    }
    return cell
  }
}
