//
//  Error.swift
//  MyWorld
//
//  Created by info-mac6 on 06/03/20.
//  Copyright © 2020 InfoCepts. All rights reserved.
//

import Foundation

public enum RequestError:Error{
    case badFormatURL
    case noResponse
    case invalidResponse
    case invalidData
}



