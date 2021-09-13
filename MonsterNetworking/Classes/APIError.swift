//
//  APIError.swift
//  Cloud
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 印聪. All rights reserved.
//

import Foundation


public class APIError: NSObject, Error {

    public var code: NSInteger = 0
    public var message: String = ""
    public var result: [String: Any]? = nil
    
    init(_ code: NSInteger, message: String? = nil, result: [String: Any]? = nil) {
        super.init()
        self.code = code
        self.result = result
        self.message = message ?? ""
    }
}
