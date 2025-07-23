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
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemDescLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    weak var delegate: MenuTableViewCellProtocol?
    private var imageUrlString: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
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
        addBtn.tag = item.itemID
        imageUrlString = item.imageURL
    }
    
    func setupCell() {
        minusBtn.isHidden = false
        quantityLbl.isHidden = false
        plusBtn.isHidden = false
        addBtn.isHidden = true
    }
    
    @IBAction func addBtnAction(_ sender: UIButton) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "itemID == %d", addBtn.tag)

        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let cartItem = CartItem(context: context)
                cartItem.itemID = Int64(addBtn.tag)
                cartItem.itemName = itemNameLbl.text
                cartItem.itemDescription = itemDescLbl.text
                cartItem.itemPrice = itemPriceLbl.text
                cartItem.imageURL = imageUrlString
                cartItem.quantity = 1
                CoreDataManager.shared.saveContext()
                delegate?.showMessage(msg: StringConstants.success.rawValue, desc: StringConstants.successMsg.rawValue)
            } else {
                delegate?.showMessage(msg: StringConstants.oops.rawValue, desc: StringConstants.oopsMsg.rawValue)
            }
        } catch {
            print("Error checking cart item: \(error.localizedDescription)")
        }
    }
}
