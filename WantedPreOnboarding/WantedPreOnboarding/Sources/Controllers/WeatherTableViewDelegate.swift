//
//  WeatherTableViewDelegate.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/14.
//

import Foundation
import UIKit

protocol MainViewControllerDelegate: AnyObject {

    func selectedCell(indexPath: IndexPath)
}

final class WeatherTableViewDelegate: NSObject {

    // MARK: Proeprty

    weak var delegate: MainViewControllerDelegate?

    // MARK: Initializer

    init(withDelegate delegate: MainViewControllerDelegate) {
        self.delegate = delegate
    }

}

// MARK: - UITableViewDelegate

extension WeatherTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath: indexPath)
    }
}
