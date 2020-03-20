//
//  Country.swift
//  MyWorld
//
//  Created by info-mac6 on 05/03/20.
//  Copyright © 2020 InfoCepts. All rights reserved.
//
//This struct has String name and flag
public struct Country:Codable,Equatable{
    public var name:String?
    public var flag:String?
}
//This extension is compare the key from JSON
public extension Country{
    init?(withJson json:[String:Any]){
        guard let name = json["name"] as? String,
            let flag = json["flag"] as? String
            else { return nil }
        self.name = name
        self.flag = flag
    }
}

