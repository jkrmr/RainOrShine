//
//  WeatherCell.swift
//  RainOrShine
//
//  Created by Jake Romer on 3/27/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
  @IBOutlet weak var forecastImage: UIImageView!
  @IBOutlet weak var forecastDay: UILabel!
  @IBOutlet weak var forecastDescription: UILabel!
  @IBOutlet weak var forecastMaxTemp: UILabel!
  @IBOutlet weak var forecastMinTemp: UILabel!

  var forecast: WeatherForecast! {
    didSet {
      forecastImage.image = UIImage(named: forecast.weatherType)
      forecastDay.text = forecast.dayOfWeek
      forecastMaxTemp.text = "\(forecast.tempMax)º"
      forecastMinTemp.text = "\(forecast.tempMin)º"
      forecastDescription.text = forecast.weatherType
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
