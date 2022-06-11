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
        
        //Act
        networkManager.getAPI(url: "", resultType: String.self) { result in
            
            //Assert
            switch result{
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL)
            }
            
        }
    }


    func testGetMethod_WhenDataIsValid_ShouldReturnSuccess(){
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let jsonData = getData(name: "TrendingAPIResponse")
        MockURLProtocol.mockData = jsonData
                
        let netManager = NetworkManager(urlSession: urlSession)
        
        let expectation = self.expectation(description: "Network Manager Valid Data")
        
        netManager.getAPI(url: "www.google.com", resultType: TrendingResponse.self) { result in
            
            switch result{
            case .success(let model):
                XCTAssertEqual(model.items[0].name, "go")
                expectation.fulfill()
                break
            case .failure(_):
                break
            }
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testGetMethod_WhenDataIsInvalid_ShouldReturnInvalidDataError(){
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let jsonData = Data()
        MockURLProtocol.mockData = jsonData
                
        let netManager = NetworkManager(urlSession: urlSession)
        
        let expectation = self.expectation(description: "Network Manager Invalid Data")
        
        netManager.getAPI(url: "www.google.com", resultType: TrendingResponse.self) { result in
            
            switch result{
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual(error, .invalidData)
                expectation.fulfill()
                break
            }
        }
        self.wait(for: [expectation], timeout: 10)
    }
    
    
    func getData(name : String)->Data{

       let bundle =  Bundle(for: type(of: self)).url(forResource: name, withExtension: "json")!
        return try! Data(contentsOf: bundle)
    }
    

}
