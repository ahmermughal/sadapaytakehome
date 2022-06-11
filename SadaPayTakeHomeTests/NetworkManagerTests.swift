//
//  NetworkManagerTests.swift
//  SadaPayTakeHomeTests
//
//  Created by Ahmer Mughal on 6/11/22.
//

import XCTest
@testable import SadaPayTakeHome

class NetworkManagerTests: XCTestCase {

    var networkManager : NetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testGetMethod_WhenEmptyURLProvided_ShouldInvalidURLError(){
        
        networkManager.getAPI(url: "", resultType: String.self) { result in
            
            switch result{
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL)
            }
            
        }
    }



}
