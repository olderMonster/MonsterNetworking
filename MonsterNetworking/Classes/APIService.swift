//
//  BaseURLSource.swift
//  SwiftProject
//
//  Created by 印聪 on 2020/7/28.
//  Copyright © 2020 印聪. All rights reserved.
//

public protocol APIService {

    //请求链接
    var baseURL: String { get }
}


extension APIService {
    
    var baseURL: String {
        return ""
    }

}

