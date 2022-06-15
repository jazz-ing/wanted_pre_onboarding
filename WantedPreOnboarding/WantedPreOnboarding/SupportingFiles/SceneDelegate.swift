//
//  SceneDelegate.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let _ = (scene as? UIWindowScene) else { return }

        if let navigationController = window?.rootViewController as? UINavigationController,
           let mainWeatherViewController = navigationController.topViewController
            as? MainWeatherViewController
        {
            mainWeatherViewController.weatherDataUseCase = WeatherDataUseCase()
            mainWeatherViewController.iconImageUseCase = IconImageUseCase()
        }
    }
}
