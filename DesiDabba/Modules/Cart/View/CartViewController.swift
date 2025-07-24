//
//  CartVC.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

import UIKit
import CoreData

class CartViewController: UIViewController {

    // MARK: IBOUTLETS
    @IBOutlet weak var cartTblView: UITableView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var totalView: UIView!
    var cartItems: [CartItem] = []
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCartItems()
        setupTableView()
    }
    
    // MARK: METHODS
    static func loadNib() -> CartViewController {
        return CartViewController(nibName: FileNames.cartViewController.rawValue, bundle: nil)
    }
    
    func setupUI() {
        proceedBtn.layer.cornerRadius = 10
        totalView.layer.cornerRadius = 10
        totalView.layer.borderColor = UIColor.systemGray2.cgColor
        totalView.layer.borderWidth = 1
    }
    
    func setupTableView() {
        cartTblView.delegate = self
        cartTblView.dataSource = self
        cartTblView.register(UINib(nibName: FileNames.menuTableViewCell.rawValue, bundle: nil),
                             forCellReuseIdentifier: FileNames.menuTableViewCell.rawValue)
    }
    
    func fetchCartItems() {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()

        do {
            cartItems = try context.fetch(fetchRequest)
            cartTblView.reloadData()
            updateTotal()
        } catch {
            print("Error fetching cart items: \(error.localizedDescription)")
        }
    }
    
    func updateTotal() {
        let total = cartItems.reduce(into: 0.0) { sum, item in
            let price = Double(item.itemPrice ?? "0") ?? 0.0
            sum += price * Double(item.quantity)
        }
        totalLbl.text = "Rs. \(Int(total))"
    }
}

// MARK: IBACTION METHODS
extension CartViewController {
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func proceedBtnAction(_ sender: UIButton) {
        if cartItems.count == 0 {
            self.showAlert(title: AlertMessages.sorry.rawValue, message: AlertMessages.sorryMsg.rawValue)
        } else {
            let vc = CheckoutViewController.loadNib()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: MenuTableViewCell Delegate Methods
extension CartViewController: MenuTableViewCellProtocol {
    func showMessage(msg: String, desc: String) {}
    
    func deleteElement(itemId: Int) {
        if let index = cartItems.firstIndex(where: { $0.itemID == itemId }) {
            cartItems.remove(at: index)
            updateTotal()
            cartTblView.reloadData()
        }
    }
    
    func updateElement(itemId: Int) {
        updateTotal()
    }
}

// MARK: TableView Delegate & Datasource Methods
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.setupCell(item: cartItems[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = cartItems[indexPath.row]
            let context = CoreDataManager.shared.context
            context.delete(itemToDelete)
            CoreDataManager.shared.saveContext()
            cartItems.remove(at: indexPath.row)
            tableView.reloadData()
            updateTotal()
        }
    }
}
