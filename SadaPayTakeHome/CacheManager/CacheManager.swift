//
//  CacheManager.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import Foundation
import UIKit



class CacheManager<T>{
    private let nsCache = NSCache<NSString, CacheData>()
    
    func add(value: T, key: NSString){
        let cacheData = CacheData(value: value)
        nsCache.setObject(cacheData, forKey: key)
    }
    
    func getValueFor(key: NSString)->T?{
        let cacheData = nsCache.object(forKey: key)
        return cacheData?.value
    }
    
}

extension CacheManager{
    class CacheData{
        let value : T
        
        init(value: T){
            self.value = value
        }
    }
}
