//
//  WeatherDataUseCase.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/12.
//

import Foundation

enum WeatherDataUseCaseError: LocalizedError {
    
    case selfNotFound

    var errorDescription: String? {
        switch self {
        case .selfNotFound:
            return "UseCase를 찾을 수 없습니다."
        }
    }
}

protocol WeatherDataUseCaseType {
    
    var isFetching: Bool { get }
    var isLastData: Bool { get }
    var index: Int { get }
    
    func fetchCurrentWeather(completion: @escaping (Result<CurrentWeather, Error>) -> Void)
}

final class WeatherDataUseCase: WeatherDataUseCaseType {

    // MARK: Properties

    private let decodingManager: DecodingManager
    private let networkManager: NetworkManagerType
    var isFetching = false
    var isLastData = false
    var index = 0
    private let lastIndex = 19
    private let citys = [
        "Gongju", "Gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan",
        "Seoul", "Sokcho", "Suwon", "Suncheon", "Ulsan", "Iksan", "Jeonju", "Jeju", "Cheonan",
        "Chungju", "Chuncheon"
    ]

    // MARK: Initializer

    init(
        decodingManager: DecodingManager = DecodingManager(),
        networkManager: NetworkManagerType = NetworkManager()
    ) {
        self.decodingManager = decodingManager
        self.networkManager = networkManager
    }

    // MARK: Data fetching method

    func fetchCurrentWeather(completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        if isFetching || isLastData {
            return
        }
        
        isFetching = true
        
        networkManager.request(
            to: WeatherEndPoint.getCurrentWeather(city: citys[index])
        ) { [weak self] result in
            switch result {
            case .success(let data):
                guard let decodedData = self?.decodingManager.decode(data, to: CurrentWeather.self)
                else {
                    completion(.failure(WeatherDataUseCaseError.selfNotFound))
                    return
                }
                switch decodedData {
                case .success(let currentWeather):
                    if self?.index == self?.lastIndex {
                        self?.isLastData = true
                        completion(.success(currentWeather))
                        return
                    }
                    self?.index += 1
                    completion(.success(currentWeather))
                case .failure(let decodingError):
                    completion(.failure(decodingError))
                }
            case .failure(let networkError):
                completion(.failure(networkError))
            }
            self?.isFetching = false
        }
    }
}
