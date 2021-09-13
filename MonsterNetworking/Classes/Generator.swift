//
//  APIGenerator.swift
//  SwiftProject
//
//  Created by 印聪 on 2020/7/28.
//  Copyright © 2020 印聪. All rights reserved.
//

@objc public protocol Generator {
    
    /// 通用请求头参数。eg：版本号
    /// - Returns: 请求头参数
    @objc optional func headerFields(for service: APIService) -> [String: String]?
    
    /// 通用接口请求体参数。eg：版本号
    /// - Returns: 请求体参数
    @objc optional func paramaters(for service: APIService) -> [String: String]?
}


extension Generator {
    
    @objc optional func headerFields(for service: APIService) -> [String: String]? {
        return nil
    }
    
    @objc optional func paramaters(for service: APIService) -> [String: String]? {
        return nil
    }
}
