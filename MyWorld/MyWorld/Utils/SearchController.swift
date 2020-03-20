//
//  SearchController.swift
//  MyWorld
//
//  Created by info-mac6 on 06/03/20.
//  Copyright © 2020 InfoCepts. All rights reserved.
//

import UIKit

class SearchController:UISearchController{
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.tintColor = .black
        searchBar.barStyle = .black
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = PlaceHolder.name
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .black
    }
}

struct PlaceHolder {
    static let name = "Search Country"
}
