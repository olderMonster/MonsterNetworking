//
//  BaseURLSource.swift
//  SwiftProject
//
//  Created by 印聪 on 2020/7/28.
//  Copyright © 2020 印聪. All rights reserved.
//

public protocol APIService {

    //请求BaseURL
    var baseURL: String { get }
    
    //请求完整URL
//    func absoluteURL(_ methodName: String) -> String
    
    /// 公共参数(所有接口均需要的参数)
    var commonParamaters: [String: Any] { get }
}


extension APIService {
    
    var baseURL: String {
        return ""
    }
    
    func absoluteURL(_ methodName: String) -> String {
        assert(baseURL.isEmpty == false, "baseURL不能为空")
        return "\(baseURL)/\(methodName)"
    }
    
    var commonParamaters: [String: Any] {
        return [String: Any]()
    }
    
}

