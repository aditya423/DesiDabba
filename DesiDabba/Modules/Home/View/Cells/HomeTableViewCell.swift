//
//  HomeTableViewCell.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    // MARK: IBOUTLETS
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        restaurantImg.layer.cornerRadius = 10
    }
    
    func setupCell(data: Restaurant) {
        restaurantName.text = data.restaurantName
        restaurantType.text = data.type
    }
}
