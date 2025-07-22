//
//  HomeVM.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

class HomeViewModel {
    
    var restaurants: [Restaurant] = []
    
    func getRestaurantsList(completion: @escaping ([Restaurant]?, Error?) -> (Void)) {
        RestaurantService.restaurantList(completion: { data, error in
            if let value = data {
                self.restaurants = value
                completion(value, nil)
            } else {
                completion(nil, error)
            }
        })
    }
}
