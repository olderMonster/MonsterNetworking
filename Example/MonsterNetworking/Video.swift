//
//  Video.swift
//  Monster_Example
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Video {
    
    var room_id: String
    var room_src: String
    var vertical_src: String
    var isVertical: Int
    var cate_id: Int
    var room_name: String
    var show_status: Int
    var subject: String
    var show_time: Double
    var owner_uid: String
    var specific_catalog: String
    var specific_status: String
    var vod_quality: String
    var nickname: String
    var online: Int
    var hn: Int
    var url: String
    var game_url: String
    var game_name: String
    var child_id: Int
    var avatar: String
    var avatar_mid: String
    var avatar_small: String
    var jumpUrl: String
    var fans: String
    var ranktype: Int
    var is_noble_rec: Int
    var anchor_city: String
    
    init(json: JSON) {
        room_id = json["room_id"].stringValue
        room_src = json["room_src"].stringValue
        
        vertical_src = json["vertical_src"].stringValue
        isVertical = json["isVertical"].intValue
        cate_id = json["cate_id"].intValue
        room_name = json["room_name"].stringValue
        show_status = json["show_status"].intValue
        subject = json["subject"].stringValue
        show_time = json["show_time"].doubleValue
        owner_uid = json["owner_uid"].stringValue
        specific_catalog = json["specific_catalog"].stringValue
        specific_status = json["specific_status"].stringValue
        vod_quality = json["vod_quality"].stringValue
        nickname = json["nickname"].stringValue
        online = json["online"].intValue
        hn = json["hn"].intValue
        url = json["url"].stringValue
        game_url = json["game_url"].stringValue
        game_name = json["game_name"].stringValue
        child_id = json["child_id"].intValue
        avatar = json["avatar"].stringValue
        avatar_mid = json["avatar_mid"].stringValue
        avatar_small = json["avatar_small"].stringValue
        jumpUrl = json["jumpUrl"].stringValue
        fans = json["fans"].stringValue
        ranktype = json["ranktype"].intValue
        is_noble_rec = json["is_noble_rec"].intValue
        anchor_city = json["anchor_city"].stringValue
    }
}
