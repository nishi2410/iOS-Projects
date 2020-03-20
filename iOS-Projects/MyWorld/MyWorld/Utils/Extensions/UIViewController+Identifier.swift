//
//  UIViewController+Identifier.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

/**
This extension is generated from UIViewController which  has unique String 

- returns: String

# Example #
```
// CountryCell.identifier
```

*/
import UIKit

extension UIViewController {
    class var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}
