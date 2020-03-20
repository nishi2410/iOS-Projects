//
//  Endpoints.swift
//  MyWorld
//
//  Created by info-mac6 on 06/03/20.
//  Copyright © 2020 InfoCepts. All rights reserved.
//
//This struct has all details about API and there endpoints
struct Endpoints{
    private static let baseURL = "https://restcountries.eu/rest/v2/"
    static let all = "\(baseURL)all"
    static let name = "\(baseURL)name/"
    static let searchFilter = "?fields=name;flag;population;area;latlng"
    
}
