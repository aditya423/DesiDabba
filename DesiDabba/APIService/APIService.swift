//
//  APIService.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

import Foundation

let BaseURL = "https://fakerestaurantapi.runasp.net"

enum APIServices {
    case getRestaurants
    case getRestaurantMenu
}

extension APIServices {
    var Path: String {
        let apiDomain = "/api/"
        var servicePath: String = ""
        switch self {
        case .getRestaurants: servicePath = apiDomain + "Restaurant"
        case .getRestaurantMenu: servicePath = apiDomain + "Restaurant/\(restaurantId)/menu"
        }
        return BaseURL + servicePath
    }
    
    var httpMethod: String {
        switch self {
        case .getRestaurants, .getRestaurantMenu:
            return "GET"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
}
