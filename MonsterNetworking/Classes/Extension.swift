//
//  Dictionary.swift
//  Cloud
//
//  Created by 印聪 on 2020/7/29.
//  Copyright © 2020 印聪. All rights reserved.
//


extension Dictionary {
    
    
    /// 字典合并
    /// - Parameter other: 另一个字典
    mutating func merge<S>(_ other: S?)
        where S: Sequence, S.Iterator.Element == (key: Key, value: Value){
            if let dict = other {
                for (k ,v) in dict {
                    self[k] = v
            }
        }
    }
}

