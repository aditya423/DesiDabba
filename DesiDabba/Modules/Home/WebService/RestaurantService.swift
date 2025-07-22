//
//  RestaurantService.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

import Foundation

class RestaurantService {
    
    static func restaurantList(completion: @escaping ([Restaurant]?, Error?) -> (Void)) {
        APIManager.sharedInstance.makeApiCall(serviceType: .getRestaurants) { response in
            switch response {
            case .success(let value):
                if let content = value as? Data {
                    do {
                        let responseData = try JSONDecoder().decode([Restaurant].self, from: content)
                        completion(responseData, nil)
                    } catch {
                        completion(nil, value as? Error)
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
