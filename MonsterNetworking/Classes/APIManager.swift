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
}


public typealias SResult = Swift.Result
public class APIManager  {
    public static let `default` = APIManager()
    private init() {}
    
    
    /// 默认的请求Service（当调用Request方法不传service参数时即使用该service）
    public var service: APIService?
    
    /// 全局拦截器，可同时与自定义拦截器使用，不过会先调用全局拦截器之后才会调用各个接口的拦截器
    /// 因此这里可以处理一些通用的逻辑，比如通用错误的处理，统一数据的处理
    public var interceptor: Interceptor?
    
    
    /// 网络请求
    /// - Parameters:
    ///   - methodName: 请求路径
    ///   - succeed: 成功
    ///   - failure: 失败
    public static func request(methodName: String,paramaters: [String: Any]? = nil, complention: @escaping (SResult<Any, APIError>) -> Void) {
        APIManager.request(service: nil, methodName: methodName, paramaters: paramaters, headers: nil, generator: nil, complention: complention)
    }
    
    
    
    /// 网络请求（传入service）
    /// - Parameters:
    ///   - service: HTTPService
    ///   - methodName: 请求路径
    ///   - succeed: 成功
    ///   - failure: 失败
    public static func request(service: APIService, methodName: String, paramaters: [String: Any]? = nil, complention:  @escaping (SResult<Any, APIError>) -> Void) {
        APIManager.request(service: service, methodName: methodName, paramaters: paramaters, headers: nil, method: RequestMethod.get, generator: nil, complention: complention)
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
    public static func request(service: APIService?, methodName: String, paramaters: [String: Any]?, headers:[String: String]?, method: RequestMethod = RequestMethod.get,generator: Generator?, complention: @escaping (SResult<Any, APIError>) -> Void) {
        
        let manager = APIManager.default
        guard let source = (service ?? manager.service) else {
            assertionFailure("请配置HTTPManager的source或者")
            return
        }
        
        guard let url = URL(string: source.absoluteURL(methodName)) else {
            //URL异常
            return
        }
        guard url.absoluteString.isEmpty == false else {
            //URL异常
            return
        }
        
        //配置参数项
        var params = source.commonParamaters
        params.merge(paramaters)
        
        //转化网络请求方式
        let httpMethod = (method == .get) ? HTTPMethod.get:HTTPMethod.post
        
        //配置请求headerFields
        var headerFields:[String: String] = headers ?? [String: String]()
        headerFields.merge(generator?.generatHTTPHeaders(params))
        
        AF.request(url, method: httpMethod, parameters: params, headers: HTTPHeaders(headerFields)).responseJSON { response in
            //生成request对象
            let request = HTTPRequest(url: url.absoluteString, service: source, headers: headers, paramaters: params)
            if case .success(let json) = response.result {
                let result = afterSucceedIn(request: request, result: json)
                complention(result)
            } else if case .failure(let error) = response.result {
                let result = afterFailedIn(request: request, error: error)
                complention(result)
            }
        }
        
        
        //生成Request
//        let dataRequest = SessionManager.default.request(url, method: httpMethod, parameters: params, encoding: URLEncoding.default, headers: headers)
        //请求完成，处理返回数据
        
//        dataRequest.responseJSON { [unowned manager] response in
//
//            ///拦截器处理逻辑
//            ///首先将数据交予全局拦截器处理，全局拦截器对当前数据进行业务判断，是否是成功的：
//            ///1、如果业务成功，此时将数据交予接口拦截器处理，并在接口拦截器处理完成后直接callback
//            ///2、如果业务失败，例如接口返回表示缺少参数，此时需要将错误下发至接口拦截器的错误处理后直接callback
//
//
//            let request = HTTPRequest(url: url.absoluteString, service: source, headers: headers, paramaters: params)
//
//            switch response.result {
//            case .success(let responseObject):
//
//                //这边可能是多个拦截器的处理结果。
//                //全局拦截器是拦截所有的请求数据的，此时拦截器分发业务错误至接口拦截器
//                //如，请求个人信息，此时需要传参version，但是没有传参，这个时候接口是请求成功，但是其业务是请求失败的，所以分发到接口拦截器时作为业务错误来处理
//                //默认这边的第一个拦截器为全局拦截器
//
//                if let interceptor = manager.interceptor {
//                    let response = HTTPReponse(request: request, jsonObject: responseObject)
//                    //调用拦截器，由外部确认是否是真的请求成功
//                    let result = interceptor.succeedInRequest(response: response)
//                    switch result {
//                    case .success(let res):
//                        complention(SResult.success(res.jsonObject))
//                    case .failure(let error):
//                        complention(SResult.failure(error))
//                    }
//                }else {
//                    complention(SResult.success(responseObject))
//                }
//
//
//            case .failure(let error):
//                /// 错误处理：并非所有错误需要外抛至VC处，一些通用的错误如请求超时，接口异常等直接拦截处理提示即可
//                /// 另外一些错误需要使用者选择性外抛或者直接吞掉不做处理
//                let err = APIError(request: request, code: 0, message: error.localizedDescription)
//
//                if let interceptor = manager.interceptor  {
//                    interceptor.failedInRequest(error: err)
//                }
//                complention(SResult.failure(err))
//            }
//
//        }
    }
}


//MARK: -- private method
extension APIManager {
    
    /// 全局拦截器处理完毕,，此时将数据交予接口拦截器处理
    private func afterGlobalInterceptorSucceedIn(result: SResult<HTTPReponse, APIError>) ->  SResult<HTTPReponse, APIError>? {
        guard let interceptor = self.interceptor else {
            return nil
        }
        if case .success(let response) = result {
            let intercetedRs = interceptor.succeedInRequest(response: response)
            if  case .success(let res) = intercetedRs {
                return SResult.success(res)
            } else if case .failure(let err) = intercetedRs {
                return SResult.failure(err)
            }
        }
        if case .failure(let error) = result {
            interceptor.failedInRequest(error: error)
            return SResult.failure(error)
        }
        return nil
    }
    
    
    /// 请求完成后成功的数据处理
    /// - Parameter result: 返回数据
     static private func afterSucceedIn(request:HTTPRequest, result: Any) -> SResult<Any, APIError> {
        if let interceptor = APIManager.default.interceptor {
            let response = HTTPReponse(request: request, jsonObject: result)
            //调用拦截器，由外部确认是否是真的请求成功
            let result = interceptor.succeedInRequest(response: response)
            switch result {
            case .success(let res):
                return SResult.success(res.jsonObject)
            case .failure(let error):
                return SResult.failure(error)
            }
        }else {
            return SResult.success(result)
        }
    }
    
    
    /// 请求失败的数据处理
    /// - Parameter error: 请求错误
    static private func afterFailedIn(request: HTTPRequest, error: Error) -> SResult<Any, APIError> {
        /// 错误处理：并非所有错误需要外抛至VC处，一些通用的错误如请求超时，接口异常等直接拦截处理提示即可
        /// 另外一些错误需要使用者选择性外抛或者直接吞掉不做处理
        let err = APIError(request: request, code: 0, message: error.localizedDescription)
        
        if let interceptor = APIManager.default.interceptor  {
            interceptor.failedInRequest(error: err)
        }
        return SResult.failure(err)
    }
    
}
