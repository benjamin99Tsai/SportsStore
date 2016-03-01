//
//  Product.swift
//  SportsStore
//
//  Created by Benjamin on 2/25/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

class Product : NSObject, NSCopying {
    
    private(set) var name: String;
    private(set) var productDescription: String;
    private(set) var category: String;
    
    private var stockBackingValue: Int = 0;
    private var priceBackingValue: Double = 0;
    
    // MARK:
    // --
    // MARK: Life Cycle
    
    init(name: String, description: String, category: String, price: Double, stock: Int) {
        self.name = name;
        self.productDescription = description;
        self.category = category;
        
        super.init();
        
        self.price = price;
        self.stock = stock;
    }
    
    // MARK: 
    // --
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
    
    // MARK:
    // --
    // MARK: Related Operations
    
    func calculateTax(rate: Double) -> Double {
        return min(10, self.price * rate);
    }
    
    var stockValue: Double {
        get {
            return self.price * Double(self.stock);
        }
    }
    
    // MARK:
    // --
    // MARK: NSCopying
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Product(
            name: self.name,
            description: self.productDescription,
            category: self.category,
            price: self.price,
            stock: self.stock);
    }
}


