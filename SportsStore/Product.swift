//
//  Product.swift
//  SportsStore
//
//  Created by Benjamin on 2/25/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation


enum UpsellOppertunities {
    case SwimLessons;
    case MapOfLakes;
    case SoccerVideos;
}


// MARK:
// MARK: Product Base Class

class Product : NSObject, NSCopying {
    
    private(set) var name: String;
    private(set) var productDescription: String;
    private(set) var category: String;
    
    private var stockBackingValue: Int = 0;
    private var priceBackingValue: Double = 0;
    
    // MARK: Life Cycle
    
    required init(name: String, description: String, category: String, price: Double, stock: Int) {
        self.name = name;
        self.productDescription = description;
        self.category = category;
        
        super.init();
        
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
    
    var upsells: [UpsellOppertunities] {
        get {
            return Array();
        }
    }
    
    // MARK: NSCopying
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Product(
            name: self.name,
            description: self.productDescription,
            category: self.category,
            price: self.price,
            stock: self.stock);
    }
    
    // MARK: Factory Methods
    
    class func product(name: String, description: String, category: String, price: Double, stock: Int) -> Product {
        
        return Product(
            name:name,
            description: description,
            category: category,
            price: price,
            stock: stock
        );
    }
}


class ProductComposite : Product {
    
    private let products: [Product];
    
    required init(name: String, description: String, category: String, price: Double, stock: Int) {
        fatalError("Not Implemented");
    }
    
    init(name: String, description: String, category: String, stock: Int, products: Product...) {
        self.products = products;
        super.init(name: name, description: description, category: category, price: 0, stock: stock);
    }
    
    override var price: Double {
        get {
            return self.products.reduce(0) {(total, product) -> Double in total + product.price; };
        }
        
        set {
            // Do nothing
        }
    }
}






