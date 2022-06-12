//
//  WeatherTableViewDatasource.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/12.
//

import Foundation
import UIKit

final class WeatherTableViewDatasource: NSObject {

    // MARK: Property

    var datas: [CurrentWeatherData] = []
    private let iconImageUseCase: IconImageUseCaseType

    // MARK: Initializer

    init(
        with datas: [CurrentWeatherData],
        iconImageUseCase: IconImageUseCaseType = IconImageUseCase()
    ) {
        self.datas = datas
        self.iconImageUseCase = iconImageUseCase
    }
}

// MARK: - UITableViewDataSource

extension WeatherTableViewDatasource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CurrentWeatherTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CurrentWeatherTableViewCell
        else { return UITableViewCell() }

        let weatherData = datas[indexPath.row]
        cell.configureContents(from: weatherData)

        iconImageUseCase.fetchThumbnail(of: weatherData.iconID) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    cell.configure(image: image)
                }
            case .failure(_):
                break
            }
        }

        return cell
    }
}
