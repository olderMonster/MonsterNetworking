//
//  NetIntercettor.swift
//  Monster_Example
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyJSON
import MonsterNetworking

struct NetInterceptor: Interceptor  {
    
    func succeedInRequest(response: HTTPReponse) -> Swift.Result<HTTPReponse, APIError> {
        
        guard response.jsonObject is [String: Any]  else {
            let error = APIError(request: response.request, code: 0, message: "数据格式异常")
            return SResult.failure(error)
        }
        
        let service = response.request.service as! NetService
        if service == .douyu {
            //如果是斗鱼的API，那么根据斗鱼的API返回的结构判断
            return check(response, successCode: 0, dataKey: "data", errorKey: "data")
        }
        
        //历史上的今天接口
        return check(response, successCode: 200, dataKey: "content", errorKey: "content")
    }
    
    func failedInRequest(error: APIError) {
        
    }

}


extension NetInterceptor {
    
    func check(_ response: HTTPReponse, successCode: Int, dataKey: String, errorKey: String) -> SResult<HTTPReponse, APIError> {
        let jsonObject = response.jsonObject as! [String: Any]
        let json = JSON(jsonObject)
        let code = json["code"].intValue
        if code == successCode {
            //请求成功
            var res = response
            res.jsonObject = json[dataKey]
            return SResult.success(res)
        } else {
            //请求失败
            let data = json[errorKey].stringValue
            let error = APIError(request: response.request, code: 0, message: data)
            return SResult.failure(error)
        }
    }
    
}
