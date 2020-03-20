//
//  NSKeyedArchiver+Object.swift
//  MyWorld
//
//  Created by info-mac6 on 16/03/20.
//  Copyright © 2020 InfoCepts. All rights reserved.
//

import Foundation
/**
This extension is generated from UserDefaults.
*/
extension UserDefaults {
    /**
     This method save the object
     
     - parameter object: It wil be any object
     - parameter key: Unique key
     */
    func save<T:Encodable>(customObject object: T, inKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            self.set(encoded, forKey: key)
        }
    }
    /**
     This method used to fetch the object details
     
     - parameter object: It wil be any object
     - parameter key: Unique key
     - returns: object
     
     */
    func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            }else {
                print("Couldnt decode object")
                return nil
            }
        }else {
            print("Couldnt find key")
            return nil
        }
    }
}
