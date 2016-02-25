//
//  Product.swift
//  SportsStore
//
//  Created by Benjamin on 2/25/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

class Product {
    
    private(set) var name: String;
    private(set) var description: String;
    private(set) var category: String;
    
    private var stockBackingValue: Int = 0;
    private var priceBackingValue: Double = 0;
    
    // MARK: Life Cycle
    
    init(name: String, description: String, category: String, price: Double, stock: Int) {
        self.name = name;
        self.description = description;
        self.category = category;
        self.price = price;
        self.stock = stock;
    }
    
    // MARK: Special Getters/Setters
    
    var stock: Int {
        get {
            return self.stockBackingValue;
        }
        
        set {
            self.stockBackingValue = max(0, newValue);
        }
    }
    
    private(set) var price: Double {
        get {
            return self.priceBackingValue;
        }
        
        set {
            self.priceBackingValue = max(1, newValue);
        }
    }
    
    // MARK: Related Operations
    
    func calculateTax(rate: Double) -> Double {
        return min(10, self.price * rate);
    }
    
    var stockValue: Double {
        get {
            return self.price * Double(self.stock);
        }
    }
    
}


