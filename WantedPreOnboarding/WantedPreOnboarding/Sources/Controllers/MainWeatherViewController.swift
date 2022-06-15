//
//  MainWeatherViewController.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import UIKit

final class MainWeatherViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: TableView state

    enum State {
        case loading
        case populated([CurrentWeatherData])
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
    private var tableViewDelegate: WeatherTableViewDelegate?
    var weatherDataUseCase: WeatherDataUseCaseType?
    var iconImageUseCase: IconImageUseCaseType?
    private var currentWeatherData: [CurrentWeather] = []
    private var state: State = .loading {
        didSet {
            DispatchQueue.main.async {
                self.setFooterView()
                self.tableViewDatasource?.datas = self.state.weatherDatas
                self.fetchCurrentWeather()
                self.weatherTableView.reloadData()
            }
        }
    }

    // MARK: Override

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case "ShowDetailView":
                if let cell = sender as? CurrentWeatherTableViewCell,
                   let indexPath = weatherTableView.indexPath(for: cell),
                   let detailViewController = segue.destination as? DetailWeatherViewController {
                    detailViewController.currentWeather = currentWeatherData[indexPath.row]
                    detailViewController.iconImageUseCase = iconImageUseCase
                }
            default:
                break
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setTableViewDelegate()
        fetchCurrentWeather()
    }
}

// MARK: - TableView configuring method

extension MainWeatherViewController: MainViewControllerDelegate {

    private func setNavigationBar() {
        self.navigationItem.title = "오늘의 날씨"
    }

    private func setTableViewDelegate() {
        tableViewDatasource = WeatherTableViewDatasource(with: state.weatherDatas)
        tableViewDelegate = WeatherTableViewDelegate(withDelegate: self)
        weatherTableView.dataSource = tableViewDatasource
        weatherTableView.delegate = tableViewDelegate
    }
    
    private func setFooterView() {
        switch state {
        case .error(let error):
            errorLabel.text = error.localizedDescription
            weatherTableView.tableFooterView = errorView
        case .loading:
            weatherTableView.tableFooterView = loadingView
        case .populated:
            weatherTableView.tableFooterView = nil
        }
    }
    
    func selectedCell(indexPath: IndexPath) {
        weatherTableView.deselectRow(at: indexPath, animated: false)
    }
    
    func fetchCurrentWeather() {
        weatherDataUseCase?.fetchCurrentWeather { [weak self] result in
            switch result {
            case .success(let currentWeather):
                self?.setContents(from: currentWeather)
                self?.currentWeatherData.append(currentWeather)
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
            city: convertToKorean(from: currentWeather.cityName),
            temperature: temperature,
            humidity: humidity
        )
        var weatherDatas = state.weatherDatas
        weatherDatas.append(weatherData)
        state = .populated(weatherDatas)
    }

    private func convertToKorean(from cityName: String) -> String {
        switch cityName {
        case "Gongju":
            return "공주"
        case "Gwangju":
            return "광주"
        case "Gumi":
            return "구미"
        case "Gunsan":
            return "군산"
        case "Daegu":
            return "대구"
        case "Daejeon":
            return "대전"
        case "Mokpo":
            return "목포"
        case "Busan":
            return "부산"
        case "Seosan City":
            return "서산"
        case "Seoul":
            return "서울"
        case "Sokcho":
            return "속초"
        case "Suwon-si":
            return "수원"
        case "Suncheon":
            return "순천"
        case "Ulsan":
            return "울산"
        case "Iksan":
            return "익산"
        case "Jeonju":
            return "전주"
        case "Jeju City":
            return "제주"
        case "Cheonan":
            return "천안"
        case "Chungju":
            return "충주"
        case "Chuncheon":
            return "춘천"
        default:
            return "진행중"
        }
    }
}
