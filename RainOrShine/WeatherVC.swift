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
  var weatherForecasts: [WeatherForecast]?

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
      self.weatherForecasts = forecasts
    }
  }

  func updateCurrentWeather(_ currentWeather: CurrentWeather) {
    self.currentWeather = currentWeather
    self.temperatureLabel.text = "\(currentWeather.currentTemp)º"
    self.locationLabel.text = currentWeather.cityName
    self.weatherDescription.text = currentWeather.weatherType
    self.weatherImage.image = UIImage(named: currentWeather.weatherType)
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherForecasts?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
    cell.textLabel?.text = weatherForecasts?[indexPath.row].dayOfWeek
    return cell
  }
}

