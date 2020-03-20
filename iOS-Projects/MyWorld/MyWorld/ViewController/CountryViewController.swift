//
//  CountryViewController.swift
//  MyWorld
//
//  Created by info-mac6 on 06/03/20.
//  Copyright © 2020 InfoCepts. All rights reserved.
//

import UIKit
let countryKey = "Countries"
class CountryViewController:UIViewController{
    
    @IBOutlet weak var tableView: UITableView?
    private var arrOfflineCountry = [Country]()
    
    private let searchController = SearchController(searchResultsController: nil)

    private let countryViewModel = CountryViewModel()
    
    private var countries = [Country]()
    {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.tableView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My World"
        navigationController?.isNavigationBarHidden = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.hidesBackButton = true
        
        countryViewModel.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        
        setupSearchBar()
        reloadTableWithSaveCountries()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }
    
    private func setupSearchBar(){
        searchController.searchBar.delegate = self as? UISearchBarDelegate
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    //Removing duplicates from Struct array
    fileprivate func unique(savedCountries: [Country]) -> [Country] {
        for country in savedCountries {
            if !countries.contains(country) {
                countries.append(country)
            }
        }
        return countries
    }
    /**
     This method show the details of the country which has been saved for offline purpose.
        
     # Notes: #
     1. This method also usefule for searching the country from country list when device is offline
     
     # Example #
     ```
     // reloadTableWithSaveCountries()
     */
    private func reloadTableWithSaveCountries(){
        let searchText = searchController.searchBar.text

        if !Reachability.isConnected() {
            //Fetch the persistence object
            var filtered = UserDefaults.standard.retrieve(object:[Country].self , fromKey: countryKey)
            filtered! = unique(savedCountries: filtered!)
            
            //If there is search text then only filtered the struct array
            if searchText!.count > 0 {
                arrOfflineCountry = filtered!.filter({ ($0.name as AnyObject).contains(searchText!) })
                self.countries = arrOfflineCountry
          } else {
                
                self.countries = filtered!
            }
            DispatchQueue.main.async { [unowned self] in
                self.tableView?.reloadData()
            }
        }
    }
    
    //Dismiss the keyboard
    // MARK: - Targets
    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchController.searchBar.endEditing(true)
    }
}
// MARK: UITableViewDataSource
extension CountryViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier) as? CountryCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        if (indexPath.row <  countries.count){
            cell.config(withCountry: countries[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
}
//  MARK: CellSubclassDelegate
extension CountryViewController:CountryCellDelegate{
    func saveCountryOfflineBtnClicked(cell: CountryCell) {
        showAlert(withMessage: "Country has been added for offline")
        guard let indexPath = self.tableView?.indexPath(for: cell) else {
            return
        }
        //Saving the selection of offline countries
        arrOfflineCountry.append(self.countries[indexPath.row])
        //To save the object
        UserDefaults.standard.save(customObject: arrOfflineCountry, inKey: countryKey)
    }
}
// MARK: - CountryViewModelDelegate
extension CountryViewController: CountryViewModelDelegate {
    func didReceiveCountries(countries: [Country]) {
        self.countries = countries
    }
    func didFailDownloadCountries(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - UISearchResultsUpdating
extension CountryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchForCountry()
    }
}
private extension CountryViewController {
    func searchForCountry() {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        //Check whether device is offline or not
        if Reachability.isConnected() {
            if searchText.count > 0{
                countryViewModel.requestCountriesByName(countryName: searchText)
            }
        } else{
          reloadTableWithSaveCountries()
        }
    }
}
