//
//  Service.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import Foundation


enum WebserviceHTTPMethod: String {
    case GET  =   "GET"
    case POST =   "POST"
}

struct Service {
    var url: String!
    var httpMethod : WebserviceHTTPMethod
    var params : [String: Any]
    var headers : [String: Any]
    
    init(httpMethod :WebserviceHTTPMethod) {
        self.httpMethod = httpMethod
        self.params = [String: Any]()
        self.headers = [HTTPHeaderKey.HTTPHeaderKeyContenttype.rawValue:HTTPHeaderValue.HTTPHeaderValueApplicationJSON.rawValue]
        
    }
}
