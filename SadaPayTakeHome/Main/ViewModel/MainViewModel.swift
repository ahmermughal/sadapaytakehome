//
//  MainViewModel.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import Foundation
protocol MainViewModelDelegate{
    
    func updateLoader(isLoading: Bool)
    func showError(error: String)
    func receivedData()
    
}
class MainViewModel{
    
    var delegate : MainViewModelDelegate!
    var repos : [Repo] = []
    
    func getTrendingData(){
        delegate.updateLoader(isLoading: true)
        NetworkManager.shared.getTrendingRepos { [weak self] result in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.delegate.updateLoader(isLoading: false)
            }
            
            switch result{
            case .success(let response):
                self.repos = response.items
                DispatchQueue.main.async {
                    self.delegate.receivedData()
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate.showError(error: error.rawValue)
                }
                break
            }
        }
        
    }
    
    
}
