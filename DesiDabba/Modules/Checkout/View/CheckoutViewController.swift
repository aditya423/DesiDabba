//
//  CheckoutVC.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

import UIKit
import CoreData
import SwiftUI

class CheckoutViewController: UIViewController {

    // MARK: IBOUTLETS
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var placeOrderBtn: UIButton!
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFields()
    }
    
    // MARK: METHODS
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
        addLeftImage(to: nameTf, systemImageName: ImageConstants.systemName.rawValue)
        addLeftImage(to: emailTf, systemImageName: ImageConstants.systemEmail.rawValue)
        addLeftImage(to: addressTf, systemImageName: ImageConstants.systemAddress.rawValue)
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
    
    private func clearCartItems() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CartItem.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            self.showAlert(title: AlertMessages.error.rawValue, message: error.localizedDescription)
        }
    }

}

// MARK: IBACTION Methods
extension CheckoutViewController {
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func placeOrderBtnAction(_ sender: UIButton) {
        if (nameTf.text?.isEmpty ?? false) || (emailTf.text?.isEmpty ?? false) || (addressTf.text?.isEmpty ?? false) {
            self.showAlert(title: AlertMessages.note.rawValue, message: AlertMessages.noteMsg.rawValue)
        } else {
            clearCartItems()
            let successView = OrderSuccessView()
            let hostingVC = UIHostingController(rootView: successView)
            hostingVC.modalPresentationStyle = .fullScreen
            self.present(hostingVC, animated: true, completion: nil)
        }
    }
}

// MARK: TextField Delegate Methods
extension CheckoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
