//
//  DecodingManager.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/12.
//

import Foundation

enum DecodingError: LocalizedError {

    case decodingFail

    var errorDescription: String? {
        switch self {
        case .decodingFail:
            return "디코딩에 실패했습니다."
        }
    }
}

struct DecodingManager {

    private let decoder = JSONDecoder()

    func decode<Model: Decodable>(
        _ data: Data,
        to model: Model.Type
    ) -> Result<Model, DecodingError> {
        guard let decodedData = try? decoder.decode(model, from: data) else {
            return .failure(.decodingFail)
        }
        return .success(decodedData)
    }
}
