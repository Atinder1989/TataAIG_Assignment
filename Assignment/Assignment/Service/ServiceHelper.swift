//
//  ServiceHelper.swift
//  Assignment
//
//  Created by Atinderpal Singh on 05/02/19.
//  Copyright © 2019 Abc. All rights reserved.
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





