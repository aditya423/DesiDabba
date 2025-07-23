//
//  RestaurantList.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

struct Restaurant: Codable {
    let restaurantID: Int?
    let restaurantName, address, type: String?
    let parkingLot: Bool?
}
