//
//  SplashViewController.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

import UIKit

class SplashVC: UIViewController {

    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ImageConstants.appLogo.rawValue))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        setupLayout()
        animateLogo()
    }

    private func setupLayout() {
        view.addSubview(logoImageView)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func animateLogo() {
        logoImageView.alpha = 0
        logoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(withDuration: 1.5,
                       delay: 0.2,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseInOut,
                       animations: {
            self.logoImageView.alpha = 1
            self.logoImageView.transform = .identity
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let homeVC = HomeViewController()
                homeVC.modalTransitionStyle = .crossDissolve
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true, completion: nil)
            }
        })
    }
}
