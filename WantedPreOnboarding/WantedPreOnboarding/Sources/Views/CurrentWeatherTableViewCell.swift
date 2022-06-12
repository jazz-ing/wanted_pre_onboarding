//
//  CurrentWeatherTableViewCell.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: CurrentWeatherTableViewCell.self)

    // MARK: IBOutlets

    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
}
