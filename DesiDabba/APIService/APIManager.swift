//
//  APIManager.swift
//  DesiDabba
//
//  Created by Aditya on 23/07/25.
//

import Foundation

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    private override init() {}
    
    func makeApiCall(serviceType: APIServices, completion: @escaping (Result<Any, Error>) -> (Void)) {
        
        let session = URLSession.shared
        
        let url = URL(string: serviceType.Path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = serviceType.httpMethod
        
        if let params = serviceType.parameters {
            if serviceType.httpMethod == "POST" {
                var requestBodyComponents = URLComponents()
                requestBodyComponents.queryItems = params.map {
                    (key, value) in
                    URLQueryItem(name: key, value: String(describing: value))
                }
                urlRequest.httpBody = requestBodyComponents.query?.data(using: .utf8)
            }
            else {
                var urlComponents = URLComponents(string: serviceType.Path)!
                urlComponents.queryItems = params.map {
                    (key, value) in
                    URLQueryItem(name: key, value: String(describing: value))
                }
                urlRequest.url = urlComponents.url
            }
        }
        
        let task = session.dataTask(with: urlRequest) {
            data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let content = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(content))
        }
        
        task.resume()
    }
}
