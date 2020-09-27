//
//  HTTPRequest.swift
//  Cloud
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 印聪. All rights reserved.
//

import Foundation

public struct HTTPRequest {
    public fileprivate(set) var url: String
    public fileprivate(set) var service: APIService
    public fileprivate(set) var headers: [String: String]?
    public fileprivate(set) var paramaters: [String: Any]?
}
