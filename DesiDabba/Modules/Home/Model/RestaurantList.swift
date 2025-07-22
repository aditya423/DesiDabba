//
//  RestaurantList.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

struct RestaurantList: Codable {
    var data: [Restaurant]?
}

struct Restaurant: Codable {
    var restaurantID: Int?
    var restaurantName, address, type: String?
    var parkingLot: Bool?
}
