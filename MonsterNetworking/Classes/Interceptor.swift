//
//  Interceptor.swift
//  SwiftProject
//
//  Created by 印聪 on 2020/7/28.
//  Copyright © 2020 印聪. All rights reserved.
//

import Foundation
import Alamofire


/// Request拦截器
public protocol RequestInterceptor {
    func request(of request: APIRequest) -> APIRequest
}
extension RequestInterceptor {
    func request(of request: APIRequest) -> APIRequest { request }
}



/// Response拦截器
public protocol ResponseInterceptor {
    
    /// 网络请求成功处理返回数据。如请求获得的是加密后的数据，此时可以先解密处理。
    /// - Returns: 处理后的数据,以及当前业务状态(成功或者失败)
    func succeed(in request: APIRequest, result: Any) -> Result<Any, APIError>
    
    /// 网络请求失败
    func failed(in request: APIRequest, error: APIError)
}

extension ResponseInterceptor {
    func succeed(in request: APIRequest, result: Any) -> Any { (true, result) }
    func failed(in request: APIRequest, error: APIError) {}
}

