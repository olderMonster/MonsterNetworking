# MonsterNetworking

[![CI Status](https://img.shields.io/travis/olderMonster/MonsterNetworking.svg?style=flat)](https://travis-ci.org/olderMonster/MonsterNetworking)
[![Version](https://img.shields.io/cocoapods/v/MonsterNetworking.svg?style=flat)](https://cocoapods.org/pods/MonsterNetworking)
[![License](https://img.shields.io/cocoapods/l/MonsterNetworking.svg?style=flat)](https://cocoapods.org/pods/MonsterNetworking)
[![Platform](https://img.shields.io/cocoapods/p/MonsterNetworking.svg?style=flat)](https://cocoapods.org/pods/MonsterNetworking)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MonsterNetworking is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MonsterNetworking'
```

## Use
```
1、定义应用的环境，如开发、测试、生产
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

2、在didFinishLaunchingWithOptions中配置当前的环境，如果不配置，那么默认为生产
//配置当前网络环境
APIStatus.shared.current = APIStatus.test

3、配置网络请求数据来源，比如应用内有多个数据来源时。同时根据环境确定每个数据来源。
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


```

## Author

olderMonster, 406416312@qq.com

## License

MonsterNetworking is available under the MIT license. See the LICENSE file for more info.
