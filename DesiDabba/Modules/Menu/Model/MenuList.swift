//
//  MenuList.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

struct MenuItem: Codable {
    let itemID: Int
    let itemName, itemDescription: String
    let itemPrice: Int
    let restaurantName: String
    let restaurantID: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case itemID, itemName, itemDescription, itemPrice, restaurantName, restaurantID
        case imageURL = "imageUrl"
    }
}
