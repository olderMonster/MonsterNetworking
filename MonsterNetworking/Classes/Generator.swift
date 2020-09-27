//
//  APIGenerator.swift
//  SwiftProject
//
//  Created by 印聪 on 2020/7/28.
//  Copyright © 2020 印聪. All rights reserved.
//

public protocol Generator {
    
    /// HTTPHeader生成器
    /// - Parameter paramaters: HTTPBody参数
    func generatHTTPHeaders(_ paramaters: [String: Any]?) -> [String:String]?
    
}


extension Generator {
    
    /// HTTPHeader生成器
    /// - Parameter paramaters: HTTPBody参数
    func generatHTTPHeaders(_ paramaters: [String: Any]?) -> [String:String]? {
        return ["Accept":"application/text/html"]
    }
    
}
