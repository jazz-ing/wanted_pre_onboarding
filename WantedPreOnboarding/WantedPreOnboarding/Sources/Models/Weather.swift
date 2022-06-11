//
//  Weather.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import Foundation

struct Weather: Decodable {

    let id: Int
    let main: String
    let description: String
    let iconID: String

    enum CodingKeys: String, CodingKey {
        case id, main, description
        case iconID = "icon"
    }
}
