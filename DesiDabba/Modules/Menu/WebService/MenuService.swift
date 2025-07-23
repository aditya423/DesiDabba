//
//  MenuService.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

import Foundation

class MenuService {
    
    static func menuList(completion: @escaping ([MenuItem]?, Error?) -> (Void)) {
        APIManager.sharedInstance.makeApiCall(serviceType: .getRestaurantMenu) { response in
            switch response {
            case .success(let value):
                if let content = value as? Data {
                    do {
                        let responseData = try JSONDecoder().decode([MenuItem].self, from: content)
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
