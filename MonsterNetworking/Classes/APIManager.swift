//
//  APIManager.swift
//  SwiftProject
//
//  Created by 印聪 on 2020/7/28.
//  Copyright © 2020 印聪. All rights reserved.
//

import Alamofire


public enum RequestMethod {
    case get
    case post
    
    var value: HTTPMethod {
        switch self {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        }
    }
}


//public typealias SResult = Swift.Result
public class APIManager  {
    public static let `default` = APIManager()
    private init() {}
    
    
    /// 默认的请求Service（当调用Request方法不传service参数时即使用该service）
    public var service: APIService?
    
    /// 全局拦截器，可同时与自定义拦截器使用，不过会先调用全局拦截器之后才会调用各个接口的拦截器
    /// 因此这里可以处理一些通用的逻辑，比如通用错误的处理，统一数据的处理
    public var requestInterceptor: RequestInterceptor?
    public var responseInterceptor: ResponseInterceptor?
    
    /// 参数生成
    public var generator: Generator?
    
    
    /// 网络请求
    /// - Parameters:
    ///   - methodName: 请求路径
    ///   - succeed: 成功
    ///   - failure: 失败
    public static func request(methodName: String,paramaters: [String: Any]? = nil, handler: @escaping (Result<Any, APIError>) -> Void) {
        APIManager.request(service: nil, methodName: methodName, paramaters: paramaters, headers: nil, handler: handler)
    }
    
    
    
    /// 网络请求（传入service）
    /// - Parameters:
    ///   - service: HTTPService
    ///   - methodName: 请求路径
    ///   - succeed: 成功
    ///   - failure: 失败
    public static func request(service: APIService, methodName: String, paramaters: [String: Any]? = nil, handler: @escaping (Result<Any, APIError>) -> Void) {
        APIManager.request(service: service, methodName: methodName, paramaters: paramaters, headers: nil, method: RequestMethod.get, handler: handler)
    }
    
    
    
    /// 网络请求(包括设置headers，连接器等)
    /// - Parameters:
    ///   - source: BaseURL源
    ///   - methodName: 请求路径
    ///   - paramaters: 参数
    ///   - headers: HTTPFields,该参数用于单个请求另外设置HTTPFields，一般情况下s都是统一设置HTTPFields
    ///   - method: 请求方式
    ///   - generator: 生成器，可自定义HTTPFields
    ///   - interceptor: 拦截器，用于拦截Request以及Response，对所拦截的对象进行处理
    ///   - succeed: 成功
    ///   - failure: 失败
    public static func request(service: APIService?, methodName: String, paramaters: [String: Any]?, headers:[String: String]?, method: RequestMethod = RequestMethod.get, handler: @escaping (Result<Any, APIError>) -> Void) {
        
        guard let service = service ?? APIManager.default.service else {
            assertionFailure("网络请求service不能为空")
            return
        }
        var requestParamaters = paramaters ?? [String: Any]()
        var headerFields = headers ?? [String: String]()
        if let generator = APIManager.default.generator {
            if let params = generator.paramaters(for: service), !params.isEmpty {
                params.forEach({ requestParamaters[$0] = $1 })
            }
            if let fields = generator.headerFields(for: service), !fields.isEmpty {
                fields.forEach({ headerFields[$0] = $1 })
            }
        }
        var request = APIRequest(service, methodName: methodName, paramaters: requestParamaters, headers: headerFields)
        if let requestInterceptor = APIManager.default.requestInterceptor {
            request = requestInterceptor.request(of: request)
        }
        AF.request(request.url, method: method.value, parameters: request.paramaters, headers: HTTPHeaders(request.headerFields)).responseJSON { response in
            if case .success(let result) = response.result {
                let result = before(throwOut: request, of: result)
                handler(result)
            } else if case .failure(let error) = response.result {
                let result = before(handle: request, of: error)
                handler(result)
            }
        }
    }
}


//MARK: -- private method
extension APIManager {
    
    
    /// 请求完成后成功的数据处理
    /// - Parameter result: 返回数据
     static private func before(throwOut request: APIRequest, of result: Any) -> Result<Any, APIError> {
        if let interceptor = APIManager.default.responseInterceptor {
            //调用拦截器，由外部确认是否是真的请求成功
            let response = interceptor.succeed(in: request, result: result)
            switch response {
            case .success(let responseObject):
                return Result.success(responseObject)
            case .failure(let error):
                return before(handle: request, of: error)
            }
        }else {
            return Result.success(result)
        }
    }
    

    /// 请求失败的数据处理
    /// - Parameter error: 请求错误
    static private func before(handle request: APIRequest, of error: Error) -> Result<Any, APIError> {
        /// 错误处理：并非所有错误需要外抛至VC处，一些通用的错误如请求超时，接口异常等直接拦截处理提示即可
        /// 另外一些错误需要使用者选择性外抛或者直接吞掉不做处理
        
        var requestError = APIError(0, message: error.localizedDescription)
        if let err = error as? AFError {
            requestError = APIError(err.responseCode!, message: err.errorDescription)
        }
        if let err = error as? APIError {
            requestError = err
        }
        if let interceptor = APIManager.default.responseInterceptor {
            interceptor.failed(in: request, error: requestError)
        }
        return Result.failure(requestError)
    }
    
}
