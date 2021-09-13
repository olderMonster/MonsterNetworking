//
//  HTTPRequest.swift
//  Cloud
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 印聪. All rights reserved.
//

import Foundation

@objc public class APIRequest: NSObject {
    public fileprivate(set) var url: URL
    public fileprivate(set) var service: APIService
    public fileprivate(set) var headerFields: [String: String] = [:]
    public fileprivate(set) var paramaters: [String: Any] = [:]
    
    init(_ service: APIService, methodName: String, paramaters: [String: Any]?, headers: [String: String]?) {
        let urlString = service.baseURL + "/" + methodName
        let url = URL(string: urlString) 
        if url == nil {
            assertionFailure("初始化\(urlString)失败")
        }
        self.url = url!
        self.service = service
        
        var params: [String: Any] = service.commonParamaters
        if let paramaters = paramaters {
            paramaters.forEach({ params[$0] = $1 })
        }
        self.paramaters = params
        
        var fields: [String: String] = service.
        if let headers = headers {
            headers.forEach({ fields[$0] = $1 })
        }
        self.headerFields = fields
    }
}
