//
//  StockTotalFacade.swift
//  SportsStore
//
//  Created by Benjamin on 3/7/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation


class StockTotalFacade {
    
    enum Currency {
        case USD;
        case GBP;
        case EURO;
    }
    
    class func formatCurrencyAmount(amount: Double, currency: Currency) -> String? {
        var stockTotalFactoryCurrency: StockTotalFactory.Currency;
        
        switch (currency) {
            case .USD:
                stockTotalFactoryCurrency = StockTotalFactory.Currency.USD;
                
            case .GBP:
                stockTotalFactoryCurrency = StockTotalFactory.Currency.GBP
                
            case .EURO:
                stockTotalFactoryCurrency = StockTotalFactory.Currency.EURO;
        }
        
        let factory = StockTotalFactory.factory(stockTotalFactoryCurrency);
        
        if let totalAmount = factory?.converter?.convertTotal(amount) {
            if let formattedValue = factory?.formatter?.formatTotal(totalAmount) {
                return formattedValue;
            }
        }
        
        return nil;
    }
}