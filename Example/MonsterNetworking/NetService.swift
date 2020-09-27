//
//  NetService.swift
//  Monster_Example
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MonsterNetworking

enum NetService: APIService {
    case douyu
    case history
    
    var baseURL: String {
        let status = APIStatus.shared.current
        if status == APIStatus.develop {
            //开发环境
            if self == .douyu {
                //斗鱼的API
                return "http://capi.douyucdn.cn"
            }
            return "http://api.63code.com"
        }
        if status == APIStatus.test {
            //测试环境
            if self == .douyu {
                //斗鱼的API
                return "http://capi.douyucdn.cn"
            }
            return "http://api.63code.com"
        }
        
        //生产环境
        if self == .douyu {
            //斗鱼的API
            return "http://capi.douyucdn.cn"
        }
        return "http://api.63code.com"
    }
    
    var commonParamaters: [String : Any] {
        return [String: Any]()
    }
}
