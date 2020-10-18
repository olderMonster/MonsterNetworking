//
//  APIError.swift
//  Cloud
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 印聪. All rights reserved.
//

import Foundation


public struct APIError: Error {
    var request: HTTPRequest
    
    public var code: Int = 0
    public var message: String = ""
    public var result: Any? = nil
    
    public init(request: HTTPRequest, code: NSInteger, message: String? = nil) {
        self.request = request
        self.code = code
        if let text = message {
            self.message = text
        }
    }
}
