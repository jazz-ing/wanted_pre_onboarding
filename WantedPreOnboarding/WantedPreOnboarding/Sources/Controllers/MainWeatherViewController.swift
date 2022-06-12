//
//  MainWeatherViewController.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import UIKit

final class MainWeatherViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var weatherTableView: UITableView!

    // MARK: TableView state

    enum State {
        case loading
        case populated([CurrentWeatherData])
        case empty
        case error(Error)
        
        var weatherDatas: [CurrentWeatherData] {
            switch self {
            case .populated(let weatherDatas):
                return weatherDatas
            default:
                return []
            }
        }
    }

    // MARK: Properties
    
    private var tableViewDatasource: WeatherTableViewDatasource?
    private let weatherDataUseCase = WeatherDataUseCase()
    private var state: State = .loading

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
        fetchCurrentWeather()
    }
}

// MARK: - TableView configuring method

extension MainWeatherViewController {
    
    private func setTableViewDelegate() {
        tableViewDatasource = WeatherTableViewDatasource(with: state.weatherDatas)
        weatherTableView.dataSource = tableViewDatasource
    }
    
    func fetchCurrentWeather() {
        weatherDataUseCase.fetchCurrentWeather { [weak self] result in
            switch result {
            case .success(let currentWeather):
                self?.setContents(from: currentWeather)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }
    
    private func setContents(from currentWeather: CurrentWeather) {
        let celsius = currentWeather.information.temperature - 273.15
        let temperature = "\(Int(celsius))℃"
        let humidity = "습도: \(currentWeather.information.humidity)"

        let weatherData = CurrentWeatherData(
            iconID: currentWeather.weather[0].iconID,
            city: currentWeather.cityName,
            temperature: temperature,
            humidity: humidity
        )
        var weatherDatas = state.weatherDatas
        weatherDatas.append(weatherData)
        state = .populated(weatherDatas)
    }
}
