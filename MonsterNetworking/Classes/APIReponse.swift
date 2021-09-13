//
//  APIresponse.swift
//  Cloud
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 印聪. All rights reserved.
//

import Foundation

public struct APIReponse {
    public fileprivate(set) var request: HTTPRequest
    public var jsonObject: Any
}
