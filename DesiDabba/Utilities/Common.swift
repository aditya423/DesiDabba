//
//  Common.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

import Foundation
import UIKit
import SwiftLoader

// MARK: LOADER
func showLoader() {
    let parentView = UIView(frame: UIScreen.main.bounds)
    parentView.isUserInteractionEnabled = false
    var config : SwiftLoader.Config = SwiftLoader.Config()
    config.size = 105
    config.backgroundColor = .systemGray6
    config.spinnerColor = UIColor.background
    config.spinnerLineWidth = 5
    SwiftLoader.setConfig(config)
    SwiftLoader.show(animated: true)
}

func hideLoader() {
    SwiftLoader.hide()
}
