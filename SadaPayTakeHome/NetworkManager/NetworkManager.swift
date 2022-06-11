//
//  NetworkManager.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import Foundation
import UIKit

class NetworkManager{

    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/search/repositories"
    private var urlSession: URLSession
    
    
    init(urlSession : URLSession = .shared){
        self.urlSession = urlSession
    }
    
    func getTrendingRepos(completed : @escaping (Result<TrendingResponse, NetworkError>) -> Void){
        
        let urlStr = baseURL + "?q=language=+sort:stars"
        
        getAPI(url: urlStr, resultType: TrendingResponse.self) { result in
            
            switch result{
            case .success(let response):
                completed(.success(response))
                break
            case .failure(let error):
                completed(.failure(error))
                break
            }
        }
    }
    
    func getAPI<T:Decodable>(url : String, resultType: T.Type, completed: @escaping (Result<T, NetworkError>) -> Void){
        
        guard let url = URL(string: url) else {
            
            completed(.failure(.invalidURL))
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }

            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: data)
                completed(.success(response))
            }catch{
                completed(.failure(.invalidData))
            }
            
        }
        
        dataTask.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void){
        
        guard let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            completed(nil)
            return
        }
        
        guard let url = URL(string: urlStr) else{
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data)
            else{
                completed(nil)
                return
            }
            completed(image)
            
        }
        task.resume()
    }
    
}
