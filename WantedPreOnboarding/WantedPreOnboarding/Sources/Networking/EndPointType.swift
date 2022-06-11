//
//  EndPointType.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import Foundation

typealias RequestQuery = [String: Any]?

protocol EndPointType {
    
    var baseURL: String { get }
    var path: String { get }
    var query: RequestQuery { get }

    func configureURL() -> URL?
}
