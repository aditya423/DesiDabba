//
//  MenuVC.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var pageTitleLbl: UILabel!
    @IBOutlet weak var menuTblView: UITableView!
    let viewModel = MenuViewModel()
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTblView.delegate = self
        menuTblView.dataSource = self
        menuTblView.register(UINib(nibName: FileNames.menuTableViewCell.rawValue, bundle: nil),
                             forCellReuseIdentifier: FileNames.menuTableViewCell.rawValue)
        getMenu()
    }
    
    // MARK: METHODS
    static func loadNib() -> MenuViewController {
        return MenuViewController(nibName: FileNames.menuViewController.rawValue, bundle: nil)
    }
    
    private func getMenu() {
        showLoader()
        viewModel.getRestaurantsList { [weak self] success, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if success != nil {
                    self.pageTitleLbl.text = "\(self.viewModel.menuList.first?.restaurantName ?? "Restaurant")'s Menu"
                    self.menuTblView.reloadData()
                } else {
                    self.showAlert(title: AlertMessages.error.rawValue, message: error?.localizedDescription ?? AlertMessages.somethingWentWrong.rawValue)
                }
                hideLoader()
            }
        }
    }
}

// MARK: IBACTION METHODS
extension MenuViewController {
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtnAction(_ sender: UIButton) {
        let vc = CartViewController.loadNib()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: MenuTableViewCellProtocol Delegate Methods
extension MenuViewController: MenuTableViewCellProtocol {
    func showMessage(msg: String, desc: String) {
        self.showAlert(title: msg, message: desc)
    }
    
    func updateElement(itemId: Int) {}
    
    func deleteElement(itemId: Int) {}
}

// MARK: TableView Delegate & Datasource Methods
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FileNames.menuTableViewCell.rawValue, for: indexPath) as! MenuTableViewCell
        cell.setupCell(item: viewModel.menuList[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}
