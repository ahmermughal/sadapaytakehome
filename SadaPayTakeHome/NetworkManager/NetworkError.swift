//
//  NetworkErrors.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import Foundation

enum NetworkError: Error{
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
