//
//  UIViewController+Extension.swift
//  WantedPreOnboarding
//
//  Created by 이윤주 on 2022/06/14.
//

import UIKit

// MARK: Error alert

extension UIViewController {

    func showAlert(error: Error) {
        let alert = UIAlertController(
            title: nil,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        let okTitle = "확인"
        let popViewAction = UIAlertAction(
            title: okTitle,
            style: .cancel
        ) { _ in
            self.dismiss(animated: false)
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(popViewAction)
        self.present(alert, animated: true)
    }
}
