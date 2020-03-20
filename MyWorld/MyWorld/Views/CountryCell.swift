//
//  CountryCell.swift
//  MyWorld
//
//  Created by info-mac6 on 09/03/20.
//  Copyright © 2020 InfoCepts. All rights reserved.
//


import UIKit
import WebKit
/**
  This protocol calls when SaveOflline button clicked

  - parameter cell: UITableViewCell.
  */
protocol CountryCellDelegate: class {
    func saveCountryOfflineBtnClicked(cell: CountryCell)
}

/**
CountryCell is inherting from UITableViewCell.
- It has 3 controls i.e. UILabel, WKWebView and Button
*/
class CountryCell: UITableViewCell {
    weak var delegate: CountryCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    @IBOutlet var countryNameLabel: UILabel?
    @IBOutlet weak var btnSaveCountry: UIButton?
    @IBOutlet weak var countryFlag: WKWebView?
    
    fileprivate func hideButton() {
        if !Reachability.isConnected() {
            btnSaveCountry?.isHidden = true
        } else{
            btnSaveCountry?.isHidden = false
        }
    }
    /**
    This method add country name and flag details for UITableViewCell

    - parameter country: Should be object of Country struct.

     # Notes: #
     1. This method also hide and unhide the SaveOffline button depend upon device network
    */
    
    func config(withCountry country:Country?){
        countryNameLabel?.text = country?.name
        hideButton()
        //Show flag without adding third party lib
        let url: NSURL = NSURL(string: (country?.flag)!)!
        let request: NSURLRequest = NSURLRequest(url: url as URL)
        countryFlag!.load(request as URLRequest)
    }
    
    @IBAction func saveCountryOffline(_ sender: Any) {
        self.delegate?.saveCountryOfflineBtnClicked(cell: self)
    }
}


