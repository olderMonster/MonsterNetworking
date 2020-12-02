//
//  Interceptor.swift
//  SwiftProject
//
//  Created by 印聪 on 2020/7/28.
//  Copyright © 2020 印聪. All rights reserved.
//

import Foundation
import Alamofire


public protocol Interceptor {
    
    /// 请求成功，此时可在该方法中统一分发业务到failedInRequest中
    /// - Parameters:
    ///   - res: 返回数据
    ///   - complention: 处理后的数据
     func succeedInRequest(response: HTTPReponse) -> Swift.Result<HTTPReponse, APIError>
    
    
    /// 请求失败
    /// - Parameter error: 错误
    func failedInRequest(error: APIError)
}

extension Interceptor {
    
    
    /// 拦截器：Alamofire的Request拦截器，可在发起请求前对Request进行处理
    /// - Parameters:
    ///   - urlRequest: 请求对象
    ///   - session: Alamofire.session：AF对象
    ///   - completion: 处理后的Request回调
//    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//        return urlRequest
//    }
//    
    
    
    
    func succeedInRequest(response: HTTPReponse) -> Swift.Result<HTTPReponse, APIError> {
        //处理业务的错误，并分发出去，比如某个请求此时后台返回的code为201错误码，此时将其分发给错误
        return Swift.Result.success(response)
    }
    
    
    /// 请求失败
    /// - Parameter error: 错误
    func failedInRequest(error: APIError) {
        
    }
    
    

    /// 拦截器：请求完成(不管成功失败与否)
    /// - Parameters:
    ///   - paramaters: 当前请求参数
    ///   - response: 请求返回数据
    func complentionIn(response: HTTPReponse) {
        //这里可以处理一些通用错误，例如统一的错误提示
        
    }
}

