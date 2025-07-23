//
//  CartVC.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: IBOUTLETS
    @IBOutlet weak var cartTblView: UITableView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var proceedBtn: UIButton!
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        proceedBtn.layer.cornerRadius = 10
    }
    
    // MARK: METHODS
    static func loadNib() -> CartViewController {
        return CartViewController(nibName: FileNames.cartViewController.rawValue, bundle: nil)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func proceedBtnAction(_ sender: UIButton) {}
}
