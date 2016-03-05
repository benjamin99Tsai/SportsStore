//
//  Euro.swift
//  SportsStore
//
//  Created by Benjamin on 3/5/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation


class EuroHandler {
    
    func displayString(amount: Double) -> String {
        let formattedString = Utils.currencyStringFromNumber(amount);
        return "€\(self.dropFirst(formattedString))"
    }
    
    func currencyAmount(amount: Double) -> Double {
        return 0.76164 * amount;
    }
    
    // Use the method to removed the first caractor of the content
    func dropFirst(content: String) -> String {
        
        return content.substringWithRange(
            Range<String.Index>(start: content.startIndex.advancedBy(1), end: content.endIndex)
        );
    }
    
}
