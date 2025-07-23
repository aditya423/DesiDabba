//
//  MenuVM.swift
//  DesiDabba
//
//  Created by Aditya on 22/07/25.
//

class MenuViewModel {
    
    var menuList: [MenuItem] = []
    
    func getRestaurantsList(completion: @escaping ([MenuItem]?, Error?) -> (Void)) {
        MenuService.menuList(completion: { data, error in
            if let value = data {
                self.menuList = value
                completion(value, nil)
            } else {
                completion(nil, error)
            }
        })
    }
}
