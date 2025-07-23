//
//  MenuTableViewCell.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

import UIKit
import Kingfisher

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemDescLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    
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
        itemImg.kf.setImage(with: URL(string: item.imageURL), placeholder: UIImage(named: ImageConstants.restaurantTemp.rawValue))
        itemNameLbl.text = item.itemName
        itemDescLbl.text = item.itemDescription
        itemPriceLbl.text = "Rs. \(item.itemPrice)"
    }
    
    @IBAction func addBtnAction(_ sender: UIButton) {
    }
}
