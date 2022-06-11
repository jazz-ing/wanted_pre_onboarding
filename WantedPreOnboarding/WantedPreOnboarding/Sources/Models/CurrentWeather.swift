//
//  CurrentWeather.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import Foundation

struct CurrentWeather: Decodable {

    let weather: [Weather]
    let information: WeatherInformation
    let wind: Wind
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case weather, wind
        case information = "main"
        case cityName = "name"
    }
}
