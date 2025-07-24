//
//  MenuTableViewCell.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

import UIKit
import Kingfisher
import CoreData

class MenuTableViewCell: UITableViewCell {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemDescLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    private var menuItem: MenuItem?
    private var cartItem: CartItem?
    weak var delegate: MenuTableViewCellProtocol?
    
    // MARK: LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: METHODS
    private func setupUI() {
        itemImg.layer.cornerRadius = 10
        parentView.layer.cornerRadius = 10
        parentView.layer.borderColor = UIColor.lightGray.cgColor
        parentView.layer.borderWidth = 0.5
    }
    
    func setupCell(item: MenuItem) {
        minusBtn.isHidden = true
        quantityLbl.isHidden = true
        plusBtn.isHidden = true
        addBtn.isHidden = false
        itemImg.kf.setImage(with: URL(string: item.imageURL), placeholder: UIImage(named: ImageConstants.restaurantTemp.rawValue))
        itemNameLbl.text = item.itemName
        itemDescLbl.text = item.itemDescription
        itemPriceLbl.text = "Rs. \(item.itemPrice)"
        menuItem = item
    }
    
    func setupCell(item: CartItem) {
        minusBtn.isHidden = false
        quantityLbl.isHidden = false
        plusBtn.isHidden = false
        addBtn.isHidden = true
        itemNameLbl.text = item.itemName
        itemDescLbl.text = item.itemDescription
        itemPriceLbl.text = "Rs. \(item.itemPrice ?? "0")"
        quantityLbl.text = "\(item.quantity)"
        itemImg.kf.setImage(with: URL(string: item.imageURL ?? ""), placeholder: UIImage(named: ImageConstants.placeholder.rawValue))
        cartItem = item
    }
}

// MARK: IBACTION METHODS
extension MenuTableViewCell {
    @IBAction func addBtnAction(_ sender: UIButton) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "itemID == %d", menuItem?.itemID ?? 0)

        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let cartItem = CartItem(context: context)
                cartItem.itemID = Int64(menuItem?.itemID ?? 0)
                cartItem.itemName = menuItem?.itemName
                cartItem.itemDescription = menuItem?.itemDescription
                cartItem.itemPrice = "\(menuItem?.itemPrice ?? 0)"
                cartItem.imageURL = menuItem?.imageURL
                cartItem.quantity = 1
                CoreDataManager.shared.saveContext()
                delegate?.showMessage(msg: AlertMessages.success.rawValue, desc: AlertMessages.successMsg.rawValue)
            } else {
                delegate?.showMessage(msg: AlertMessages.oops.rawValue, desc: AlertMessages.oopsMsg.rawValue)
            }
        } catch {
            delegate?.showMessage(msg: AlertMessages.error.rawValue, desc: error.localizedDescription)
        }
    }
    
    @IBAction func minusBtnAction(_ sender: UIButton) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "itemID == %d", cartItem?.itemID ?? 0)

        do {
            if let item = try context.fetch(fetchRequest).first {
                if item.quantity > 1 {
                    item.quantity -= 1
                    quantityLbl.text = "\(item.quantity)"
                    delegate?.updateElement(itemId: Int(item.itemID))
                } else {
                    context.delete(item)
                    delegate?.deleteElement(itemId: Int(item.itemID))
                }
                CoreDataManager.shared.saveContext()
            }
        } catch {
            delegate?.showMessage(msg: AlertMessages.error.rawValue, desc: error.localizedDescription)
        }
    }
    
    @IBAction func plusBtnAction(_ sender: UIButton) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "itemID == %d", cartItem?.itemID ?? 0)

        do {
            if let item = try context.fetch(fetchRequest).first {
                item.quantity += 1
                quantityLbl.text = "\(item.quantity)"
                delegate?.updateElement(itemId: Int(item.itemID))
                CoreDataManager.shared.saveContext()
            }
        } catch {
            delegate?.showMessage(msg: AlertMessages.error.rawValue, desc: error.localizedDescription)
        }
    }
}
