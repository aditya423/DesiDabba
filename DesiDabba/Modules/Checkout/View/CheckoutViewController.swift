//
//  CheckoutVC.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var placeOrderBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFields()
    }
    
    static func loadNib() -> CheckoutViewController {
        return CheckoutViewController(nibName: FileNames.checkoutViewController.rawValue, bundle: nil)
    }
    
    private func setupUI() {
        placeOrderBtn.layer.cornerRadius = 10
    }
    
    private func setupTextFields() {
        let textFields = [nameTf, emailTf, addressTf]
        for textField in textFields {
            textField?.delegate = self
            textField?.returnKeyType = .done
        }
        addLeftImage(to: nameTf, systemImageName: "person.fill")
        addLeftImage(to: emailTf, systemImageName: "envelope.fill")
        addLeftImage(to: addressTf, systemImageName: "house.fill")
    }
    
    private func addLeftImage(to textField: UITextField, systemImageName: String) {
        let imageView = UIImageView(image: UIImage(systemName: systemImageName))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 34, height: 24))
        containerView.addSubview(imageView)
        imageView.center = containerView.center

        textField.leftView = containerView
        textField.leftViewMode = .always
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func placeOrderBtnAction(_ sender: UIButton) {
    }
}

extension CheckoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
