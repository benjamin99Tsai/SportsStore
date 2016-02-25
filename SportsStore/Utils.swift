//
//  Utils.swift
//  SportsStore
//
//  Created by Benjamin on 2/25/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

class Utils {
    
    class func currencyStringFromNumber(number: Double) -> String {
        
        let formatter = NSNumberFormatter();
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle;
        return formatter.stringFromNumber(number) ?? "";
    }
}