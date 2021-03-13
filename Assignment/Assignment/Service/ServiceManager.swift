//
//  ServiceManager.swift
//  Assignment
//
//  Created by Savleen on 11/03/21.
//

import UIKit

class ServiceManager: NSObject {
    
    class func processDataFromServer<T:Codable>(service: Service,model:T.Type,responseProcessingBlock: @escaping (T?,Error?) -> () )
    {
 
        if Utility.isNetworkAvailable() {
            Utility.showLoader()
            let request = RequestManager.sharedInstance.createRequest(service: service)
                SessionManager.sharedInstance.processRequest(request: request) { (data, error) in
                    ServiceManager.processDataModalFromResponseData(service: service, model:T.self,data: data,error: error,responseProcessingBlock: responseProcessingBlock)
            }
        } else {
            Utility.showAlert(title: "Information", message: "Please check your internet connection")
            let error: NSError = NSError.init(domain: "", code: 0,
                                                         userInfo: [NSLocalizedDescriptionKey: ""])
            responseProcessingBlock(nil, error)
        }
    }
    
    private class func processDataModalFromResponseData<T:Codable>(service:Service,model:T.Type, data:Data?,error:Error?,responseProcessingBlock: @escaping (T?,Error?) -> ())
    {
        Utility.hideLoader()
        if let responseError = error
        {
            responseProcessingBlock(nil,responseError)
            return
        }
        
        if let responseData = data
        {
            do{
                let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String:Any]
                let jsonDecoder = JSONDecoder.init()
                let parsingModel = try jsonDecoder.decode(model.self, from: responseData)
                responseProcessingBlock(parsingModel, nil)
            }
            catch(let parsingError)
            {
                responseProcessingBlock(nil,parsingError)
            }
        } else {
            
        }
    }
    
    
}
