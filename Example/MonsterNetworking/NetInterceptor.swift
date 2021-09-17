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
import Toaster


struct NetInterceptor: ResponseInterceptor  {
    
    func succeed(in request: APIRequest, result: Any) -> Result<Any, APIError> {
        if let responseObject =  result as? [String: Any] {
            let service = request.service as! NetService
            if service == .douyu {
                //如果是斗鱼的API，那么根据斗鱼的API返回的结构判断
                let code = responseObject["error"] as! Int
                if code == 0 {
                    return Result.success(responseObject["data"]!)
                }
                let message = responseObject["data"] as! String
                let error = APIError(code, message: message)
                return Result.failure(error)
            }

            //历史上的今天接口
            let code = responseObject["code"] as! Int
            if code == 200 {
                return Result.success(responseObject["content"]!)
            }
            let message = responseObject["content"] as! String
            let error = APIError(code, message: message)
            return Result.failure(error)
        }
        
        let error = APIError(0, message: "数据格式异常")
        return Result.failure(error)
    }
    
    func failed(in request: APIRequest, error: APIError) {
        Toast(text: error.message).show()
    }
    

}

