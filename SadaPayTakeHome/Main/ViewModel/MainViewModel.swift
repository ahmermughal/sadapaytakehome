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
    var isLoading = false {
        didSet {
            delegate.updateLoader(isLoading: isLoading)
        }
    }
    
    func getTrendingData(){
        isLoading = true
        NetworkManager.shared.getTrendingRepos { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let response):
                self.repos = response.items
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate.showError(error: error.rawValue)
                    self.isLoading = false
                }
                break
            }
        }
        
    }
    
    
}
