//
//  StockValueImplementations.swift
//  SportsStore
//
//  Created by Benjamin on 3/3/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation


// MARK:
// MARK: Stock Value Formatters 

protocol StockValueFormatter {
    func formatTotal(total: Double) -> String;
}


class DollarStockValueFormatter : StockValueFormatter {
    func formatTotal(total: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(total);
        return "\(formatted)";
    }
}


class PoundStockValueFormatter : StockValueFormatter {
    func formatTotal(total: Double) -> String {
        var formatted = Utils.currencyStringFromNumber(total);
        
        formatted = formatted.substringWithRange(
            Range<String.Index>(start: formatted.startIndex.advancedBy(1), end: formatted.endIndex));
        
        return "£\(formatted)";
    }
}


// MARK:
// MARK: Stock Value Converters

protocol StockValueConverter {
    func convertTotal(total: Double) -> Double;
}


class DollarStockValueConverter : StockValueConverter {
    func convertTotal(total: Double) -> Double {
        return total;
    }
}


class PoundStockValueConverter : StockValueConverter {
    func convertTotal(total: Double) -> Double {
        return 0.60338 * total;
    }
}
