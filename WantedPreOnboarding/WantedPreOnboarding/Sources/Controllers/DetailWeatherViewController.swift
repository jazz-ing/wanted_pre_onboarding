//
//  DetailWeatherViewController.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/14.
//

import UIKit

class DetailWeatherViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var windChillLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!

    // MARK: Properties

    private(set) var currentWeather: CurrentWeather?

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
