//
//  NetworkManager.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import Foundation

class NetworkManager{
    
    func getAPI<T:Any>(url : String, resultType: T.Type, completionHandler: @escaping (Result<T?, NetworkError>) -> Void){
        
        guard let url = URL(string: url) else {
            
            completionHandler(.failure(.invalidURL))
            return
        }
        
        completionHandler(.success(nil))
    }
    
}
