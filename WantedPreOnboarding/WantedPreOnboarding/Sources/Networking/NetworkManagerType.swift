//
//  NetworkManagerType.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import Foundation

typealias SessionResult = (Result<Data, NetworkError>) -> Void

protocol NetworkManagerType {
    
    func request(to urlString: String, completion: @escaping SessionResult) -> URLSessionDataTask?
    func request(to endPoint: EndPointType, completion: @escaping SessionResult)
}
