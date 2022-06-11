//
//  WeatherInformation.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import Foundation

struct WeatherInformation: Decodable {

    let temperature: Double
    let windChill: Double
    let minimumTemperature: Double
    let maximumTemperature: Double
    let pressure: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case windChill = "feels_like"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case pressure, humidity
    }
}
