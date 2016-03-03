//
//  StockValueFactories.swift
//  SportsStore
//
//  Created by Benjamin on 3/3/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation


class StockTotalFactory {
    
    enum Currency {
        case USD;
        case GBP;
    }
    
    private(set) var formatter: StockValueFormatter?;
    private(set) var converter: StockValueConverter?;
    
    class func factory(currency: Currency) -> StockTotalFactory? {
        
        var factory: StockTotalFactory? = nil;
        switch(currency) {
            case .USD:
                factory = DollarStockTotalFactory.sharedInstance;
            
            case .GBP:
                factory = PoundStockTotalFactory.sharedInstance;
        }
        
        return factory;
    }
}


private class DollarStockTotalFactory : StockTotalFactory {
    
    private override init() {
        super.init();
        self.formatter = DollarStockValueFormatter();
        self.converter = DollarStockValueConverter();
    }
    
    static var sharedInstance = DollarStockTotalFactory();
}

private class PoundStockTotalFactory : StockTotalFactory {
    
    private override init() {
        super.init();
        self.formatter = PoundStockValueFormatter();
        self.converter = PoundStockValueConverter();
    }
    
    static var sharedInstance = PoundStockTotalFactory();
}
