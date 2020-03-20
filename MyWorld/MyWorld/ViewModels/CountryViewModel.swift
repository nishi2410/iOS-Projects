//
//  CountryViewModel.swift
//  MyWorld
//
//  Created by info-mac6 on 06/03/20.
//  Copyright © 2020 InfoCepts. All rights reserved.
//
/**
 This protocol has 2 methos which pass country details on success and shows error if there is any error
  */
public protocol CountryViewModelDelegate:AnyObject{
    func didReceiveCountries(countries:[Country])
    func didFailDownloadCountries(error:Error)
}

public class CountryViewModel {
    
    public weak var delegate:CountryViewModelDelegate?
    public var service:Service?
    
    public init(service:Service=Service()){
        self.service = service
    }
    //Service for requesting all countries
    public func requestAllCountries(){
        service?.requestAllCountries(completion: completionBlock)
    }
    //Service for requesting countrie by its name
    public func requestCountriesByName(countryName: String) {
        service?.requestCountryByName(countryName: countryName, completion: completionBlock)
    }
    /**
     This completion block call delegate methods
     
     - parameter result: Country details.
     - parameter error: Error details.
     
     # Notes: #
     1. Pass error details by didFailDownloadCountries
     2. Pass country details by didReceiveCountries
     
     */
    private func completionBlock(result: [Country]?, error: Error?) {
        unowned let unownedSelf = self
        
        guard let result = result else {
            if let error = error {
                unownedSelf.delegate?.didFailDownloadCountries(error: error)
            }
            return
        }
        unownedSelf.delegate?.didReceiveCountries(countries: result)
    }
}
