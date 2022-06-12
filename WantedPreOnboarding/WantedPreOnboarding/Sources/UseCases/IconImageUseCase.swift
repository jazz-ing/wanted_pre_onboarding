//
//  IconImageUseCase.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/12.
//

import Foundation
import UIKit.UIImage

enum IconImageUseCaseError: LocalizedError {
    
    case invalidImageData
    
    var errorDescription: String? {
        switch self {
        case .invalidImageData:
            return "이미지 데이터를 불러오는 데 실패했습니다."
        }
    }
}

protocol IconImageUseCaseType {
    
    func fetchThumbnail(
        from urlString: String,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) -> URLSessionDataTask?
}

final class IconImageUseCase: IconImageUseCaseType {

    // MARK: Properties

    private let networkManager: NetworkManagerType
    private var imageCache = NSCache<NSString, UIImage>()
    
    // MARK: Initializer
    
    init(networkManager: NetworkManagerType = NetworkManager()) {
        self.networkManager = networkManager
    }

    // MARK: Icon image fetching method

    func fetchThumbnail(
        from urlString: String,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) -> URLSessionDataTask? {
        let cacheKey = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(.success(cachedImage))
            return nil
        }
        
        let task = networkManager.request(to: urlString) { [weak self] result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {
                    completion(.failure(IconImageUseCaseError.invalidImageData))
                    return
                }
                self?.imageCache.setObject(image, forKey: cacheKey)
                completion(.success(image))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
        task?.resume()
        return task
    }
}
