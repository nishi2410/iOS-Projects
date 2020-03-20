//
//  Service.swift
//  MyWorld
//
//  Created by info-mac6 on 06/03/20.
//  Copyright © 2020 InfoCepts. All rights reserved.
//

import os.log
import Foundation
/**
 This class handle the API request
 
 
 # Notes: #
 1. All types of services developer can list down here
 
 */
public class Service{
    
    typealias countryCompletion = (_ response: [Country]?, _ error: Error?) -> Void
    
    public init(){
    }
    
    func requestAllCountries(completion: @escaping countryCompletion) {
        requestCountriesData(url: Endpoints.all) { response, error in
            completion(response, error)
        }
    }
    func requestCountryByName(countryName: String, completion: @escaping countryCompletion) {
        requestCountriesData(url: Endpoints.name, queryParam: countryName) { response, error in
            completion(response, error)
        }
    }
    /**
     This method will fetch the data from API
     
     - parameter url: API URL
     - parameter filter: Country name
     - parameter completion: Generate response or error
     
     */
    private func requestCountriesData(url:String, queryParam:String = "",filter:String = Endpoints.searchFilter, completion: @escaping (_ response: [Country]?, _ error: Error?) -> Void){
        guard let validURL = URL(string: "\(url)\(queryParam)")
            else {
                os_log("Error: invalid url: %@", log: OSLog.default, type: .error, "\(url)\(queryParam)\(filter)")
                completion(nil, RequestError.badFormatURL)
                return
        }
        
        let task = URLSession.shared.dataTask(with: validURL){ data, response, error in
            guard let response = response as? HTTPURLResponse
                else{
                    completion(nil, RequestError.noResponse)
                    return
            }
            //Throw error on stastus code 200 and 404
            guard response.statusCode == 200 else {
                if response.statusCode == 404 {
                    os_log("No country matching the request was found", log: OSLog.default, type: .error)
                    completion([], nil)
                } else {
                    os_log("Unexpected response from the API: %@", log: OSLog.default, type: .error, response.debugDescription)
                    completion(nil, RequestError.invalidResponse)
                }
                return
            }
            //Throw error on invalid data
            guard let validData = data else {
                os_log("Unexpected data from the API: %@", log: OSLog.default, type: .error, data.debugDescription)
                completion(nil, RequestError.invalidData)
                return
            }
            //do catch block for throwing error
            do {
                //Throw error on Unexpected data
                guard let responseJSON = try
                    JSONSerialization.jsonObject(with: validData, options: []) as? [[String: Any]] else {
                        os_log("Unexpected data format from the API: %@", log: OSLog.default, type: .error, validData.debugDescription)
                        completion(nil, RequestError.invalidData)
                        return
                }
                var countries = [Country]()
                for data in responseJSON{
                    if let country = Country(withJson: data){
                        countries.append(country)
                    }
                }
                completion(countries, nil)
            } catch let error {
                os_log("Unexpected error during JSONSerialization: %@", log: OSLog.default, type: .error, error.localizedDescription)
                completion(nil, error)
            }
        }
        task.resume()
    }
}
