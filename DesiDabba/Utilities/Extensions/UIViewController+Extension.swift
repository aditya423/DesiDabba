//
//  UIViewController+Extension.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true)
    }
    func showAlertWithAction(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
            self.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
    func setRadius(button: UIButton) {
        button.layer.cornerRadius = 5
    }
}
