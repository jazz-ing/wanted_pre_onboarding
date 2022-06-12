//
//  CurrentWeatherTableViewCell.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {

    // MARK: Property

    static let reuseIdentifier = String(describing: CurrentWeatherTableViewCell.self)

    // MARK: IBOutlets

    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    // MARK: Override
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetContents()
    }
}

// MARK: - Cell contents configuring methods

extension CurrentWeatherTableViewCell {

    private func resetContents() {
        currentWeatherImageView.image = nil
        cityNameLabel.text = nil
        temperatureLabel.text = nil
        humidityLabel.text = nil
    }
    
    func configureContents(from data: CurrentWeatherData) {
        cityNameLabel.text = data.city
        temperatureLabel.text = data.temperature
        humidityLabel.text = data.humidity
    }
    
    func configure(image: UIImage) {
        currentWeatherImageView.image = image
    }
}
