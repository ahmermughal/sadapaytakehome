//
//  MockURLProtocol.swift
//  SadaPayTakeHomeTests
//
//  Created by Ahmer Mughal on 6/11/22.
//

import Foundation

class MockURLProtocol : URLProtocol{
    
    static var mockData : Data?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        self.client?.urlProtocol(self, didLoad: MockURLProtocol.mockData ?? Data())
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    
    override func stopLoading() {
        
    }
}
