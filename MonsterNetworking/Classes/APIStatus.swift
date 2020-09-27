//
//  OMAPIStatus.swift
//  SwiftProject
//
//  Created by 印聪 on 2020/7/28.
//  Copyright © 2020 印聪. All rights reserved.
//

//所有环境,如果环境较多，那么可以通过子类集成的方式
public class APIStatus {
    
    //开发环境
    public static let develop = "develop"
    //测试环境
    public static let test = "test"
    //正式环境
    public static let distribute = "distribute"
    
    public static let shared = APIStatus()
    private init() {}
    
    //当前网络环境
    public var current: String = APIStatus.distribute
}

