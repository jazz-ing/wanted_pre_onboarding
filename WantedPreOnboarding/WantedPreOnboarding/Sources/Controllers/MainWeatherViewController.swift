//
//  MainWeatherViewController.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import UIKit

class MainWeatherViewController: UIViewController {
    
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
    private var state: State = .loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
    }
}

// MARK: - TableView configuring method

extension MainWeatherViewController {
    
    func setTableViewDelegate() {
        tableViewDatasource = WeatherTableViewDatasource(with: state.weatherDatas)
        weatherTableView.dataSource = tableViewDatasource
    }
}
