//
//  ProductDecorator.swift
//  SportsStore
//
//  Created by Benjamin on 3/6/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation


class PriceDecorator : Product {
    
    private let wrappedProduct: Product;
    
    init(product: Product) {
        self.wrappedProduct = product;
        
        super.init(
            name: product.name,
            description: product.productDescription,
            category: product.category,
            price: product.price,
            stock: product.stock
        );
    }
    
    required init(name: String, description: String, category: String, price: Double, stock: Int) {
        fatalError("Not Supported");
    }
}


class LowStockIncreaseDecorator : PriceDecorator {
    
    override var price: Double {
        var price = self.wrappedProduct.price;
        if (self.stock < 4) {
            price = price * 1.5;
        }
        
        return price;
    }
}


class SoccerDecreaseDecorator : PriceDecorator {
    
    override var price: Double {
        return super.wrappedProduct.price * 0.5;
    }
}

