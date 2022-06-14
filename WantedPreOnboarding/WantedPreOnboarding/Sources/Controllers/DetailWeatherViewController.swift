//
//  DetailWeatherViewController.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/14.
//

import UIKit

class DetailWeatherViewController: UIViewController {

    // MARK: IBOutlets

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

    var currentWeather: CurrentWeather?
    private var iconImageUseCase: IconImageUseCaseType?

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        configureContents()
    }
}

// MARK: - View configuring method

extension DetailWeatherViewController {
    
    private func setNavigationTitle() {
        if let currentWeather = currentWeather {
            navigationItem.title = convertToKorean(from: currentWeather.cityName)
        }
    }
    
    private func configureContents() {
        configureIconImage()
        configureLabels()
    }
    
    private func configureLabels() {
        guard let currentWeather = currentWeather else {
            showAlert(error: DetailViewError.dataPassingFail)
            return
        }
        
        let currentTemperature = converToCelsius(from: currentWeather.information.temperature)
        let maximumTemperature = converToCelsius(from: currentWeather.information.maximumTemperature)
        let minimumTemperature = converToCelsius(from: currentWeather.information.minimumTemperature)
        let windChill = converToCelsius(from: currentWeather.information.windChill)

        descriptionLabel.text = currentWeather.weather[0].description
        currentTemperatureLabel.text = "\(currentTemperature)℃"
        maximumTemperatureLabel.text = "\(maximumTemperature)℃"
        minimumTemperatureLabel.text = "\(minimumTemperature)℃"
        windChillLabel.text = "\(windChill)℃"
        humidityLabel.text = currentWeather.information.humidity.description
        windSpeedLabel.text = currentWeather.wind.speed.description
        pressureLabel.text = currentWeather.information.pressure.description
    }
    
    private func configureIconImage() {
        iconImageUseCase = IconImageUseCase()
        
        if let currentWeather = currentWeather {
            iconImageUseCase?.fetchThumbnail(
                of: currentWeather.weather[0].iconID
            ) { [weak self] result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.iconImageView.image = image
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.iconImageView.image = UIImage(named: "imageDownloadFail")
                    }
                }
            }
        }
        
    }

    private func converToCelsius(from kelvin: Double) -> Int {
        return Int(kelvin - 273.15)
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

extension DetailWeatherViewController {
    
    enum DetailViewError: LocalizedError {
        case dataPassingFail
        
        var errorDescription: String? {
            switch self {
            case .dataPassingFail:
                return "데이터를 불러오는 데 실패했습니다."
            }
        }
    }
}
