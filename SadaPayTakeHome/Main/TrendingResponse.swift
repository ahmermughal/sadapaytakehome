//
//  TrendingResponse.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import Foundation

struct TrendingResponse : Codable{
    let items: [Repo]
}

struct Repo : Codable{
    
    let name : String
    let description : String
    let stars : Double
    let language : String?
    let owner : RepoOwner
    var isExpanded = false
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case stars = "stargazers_count"
        case language
        case owner
    }
    
}

struct RepoOwner : Codable{
    
    let login: String
    let avatarUrl : String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
    
}

