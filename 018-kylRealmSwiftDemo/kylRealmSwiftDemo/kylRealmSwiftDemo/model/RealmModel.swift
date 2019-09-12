//
//  RealmModel.swift
//  kylRealmSwiftDemo
//
//  Created by yulu kong on 2019/9/12.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

struct ExtraModel:ImmutableMappable {
    
    var use_ad_web_v2: Bool
    var weight: Int = 10
    var height: Int = 5
    // age 实现了get 和set 方法,可以在外面给这个属性赋值.
    var age: Int {
        
        get {
            return height * 3
        }
        
        set(newValue){  // 或者直接用 newAge
            height = newValue * 5
        }
    }


    init(map: Map) throws {
        use_ad_web_v2 = try map.value("use_ad_web_v2")
    }
}

struct ListModel:ImmutableMappable {
    
    var id: Int
    var type: Int
    var card_type: Int
    var duration: Int
    var begin_time: Int
    var end_time: Int
    var thumb: String
    var hash: String
    var logo_url: String
    var logo_hash: String
    var skip: Int
    var uri: String
    var uri_title: String
    var source: Int
    var ad_cb: String
    var resource_id: Int
    var request_id: String
    var client_ip: String
    var is_ad: Bool
    var is_ad_loc: Bool
    var extra:ExtraModel
    
    init(map: Map) throws {
        id = try map.value("id")
        type = try map.value("type")
        card_type = try map.value("card_type")
        duration = try map.value("duration")
        begin_time = try map.value("begin_time")
        end_time = try map.value("end_time")
        thumb = try map.value("thumb")
        hash = try map.value("hash")
        logo_url = try map.value("logo_url")
        logo_hash = try map.value("logo_hash")
        skip = try map.value("skip")
        uri = try map.value("uri")
        uri_title = try map.value("uri_title")
        source = try map.value("source")
        ad_cb = try map.value("ad_cb")
        resource_id = try map.value("resource_id")
        request_id = try map.value("request_id")
        client_ip = try map.value("client_ip")
        is_ad = try map.value("is_ad")
        is_ad_loc = try map.value("is_ad_loc")
        extra = try map.value("extra")
    }
    
}


class ListRealmModel: Object {
    
    @objc dynamic var key: String = "ListRealmModel"
    @objc dynamic var id: Int = 0
    @objc dynamic var type: Int = 0
    @objc dynamic var card_type: Int = 0
    @objc dynamic var duration: Int = 0
    @objc dynamic var begin_time: Int = 0
    @objc dynamic var end_time: Int = 0
    @objc dynamic var thumb: String = ""
    @objc dynamic var logo_url: String = ""
    @objc dynamic var logo_hash: String = ""
    @objc dynamic var skip: Int = 0
    @objc dynamic var uri: String = ""
    @objc dynamic var uri_title: String = ""
    @objc dynamic var source: Int = 0
    @objc dynamic var ad_cb: String = ""
    @objc dynamic var resource_id: Int = 0
    @objc dynamic var request_id: String = ""
    @objc dynamic var client_ip: String = ""
    @objc dynamic var is_ad: Bool = false
    @objc dynamic var is_ad_loc: Bool = false
    
    //设置数据库主键
    override static func primaryKey() -> String? {
        return "key"
    }
    
    func storge(list:ListModel) {
        
        self.id = list.id
        self.type = list.type
        self.card_type = list.card_type
        self.duration = list.duration
        self.begin_time = list.begin_time
        self.end_time = list.end_time
        self.thumb = list.thumb
        self.logo_url = list.logo_url
        self.logo_hash = list.logo_hash
        self.skip = list.skip
        self.uri = list.uri
        self.uri_title = list.uri_title
        self.source = list.source
        self.ad_cb = list.ad_cb
        self.resource_id = list.resource_id
        self.request_id = list.request_id
        self.client_ip = list.client_ip
        self.is_ad = list.is_ad
        self.is_ad_loc = list.is_ad_loc
    }
    
}


final class TogetherRealmModel: Object {
    
    @objc dynamic var data: Data? = nil
    @objc dynamic var key: String = ""
    
    //设置数据库主键
    override static func primaryKey() -> String? {
        return "key"
    }
}
