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
        case EURO;
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
            
            case .EURO:
                factory = EuroHandlerAdapter.sharedInstance;
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

private class EuroHandlerAdapter : StockTotalFactory, StockValueFormatter, StockValueConverter {
    
    private let handler: EuroHandler;
    
    static var sharedInstance = EuroHandlerAdapter();
    
    override init() {
        self.handler = EuroHandler();
        super.init();
        self.converter = self;
        self.formatter = self;
    }
    
    func formatTotal(total: Double) -> String {
        return self.handler.displayString(total);
    }
    
    func convertTotal(total: Double) -> Double {
        return self.handler.currencyAmount(total);
    }
}
