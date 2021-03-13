//
//  ServiceHelper.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import Foundation

class ServiceHelper: NSObject {
    static var baseURL: ServiceEnvironment {
        get {
            return ServiceEnvironment.Development
        }
    }
}

//MARK: All Apis
extension ServiceHelper {
    static func moviesPosterUrl(page:Int) -> String {
        return baseURL.rawValue + "3/movie/popular?api_key=467f65f498967957222ea3a7b57d6b54&page=\(page)"
    }
    
}





