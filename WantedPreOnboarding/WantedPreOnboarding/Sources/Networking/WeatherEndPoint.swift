//
//  WeatherEndPoint.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import Foundation

enum WeatherEndPoint: EndPointType {
    
    case getCurrentWeather(city: City)
    
    private var apiKey: String? {
        return Bundle.main.infoDictionary?["API_KEY"] as? String
    }

    var baseURL: String {
        return "https://api.openweathermap.org"
    }

    var path: String {
        return "/data/2.5/weather"
    }
    
    var query: RequestQuery {
        switch self {
        case .getCurrentWeather(let city):
            return [
                "lat": city.latitude,
                "lon": city.longitude,
                "appid": apiKey ?? "",
                "lang": "kr"
            ]
        }
    }
}

extension WeatherEndPoint {

    func configureURL() -> URL? {
        var components = URLComponents(string: self.baseURL)
        components?.path = self.path
        if let query = self.query {
            let queryItems = query.map { (key: String, value: Any) -> URLQueryItem in
                let value = String(describing: value)
                return URLQueryItem(name: key, value: value)
            }
            components?.queryItems = queryItems
        }
        return components?.url
    }
}
