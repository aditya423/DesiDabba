//
//  HomeTableViewCell.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    // MARK: IBOUTLETS
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        restaurantImg.layer.cornerRadius = 10
        parentView.layer.cornerRadius = 10
        parentView.layer.borderColor = UIColor.lightGray.cgColor
        parentView.layer.borderWidth = 0.5
    }
    
    func setupCell(data: Restaurant) {
        restaurantName.text = data.restaurantName
        restaurantType.text = data.type
    }
}
