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

    
    
}
