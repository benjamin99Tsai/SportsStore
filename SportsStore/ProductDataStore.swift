//
//  ProductDataStore.swift
//  SportsStore
//
//  Created by Benjamin on 3/1/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

final class ProductDataStore {
    
    // Properties:
    var callback: (Product -> Void)?;
    private var networkQueue: dispatch_queue_t;
    private var uiQueue: dispatch_queue_t;
    lazy var products: [Product] = self.loadData();
    
    private var productData: [Product] = [
        Product.product("Kayak", description:"A boat for one person",
        category:"Watersports", price:275.0, stock:0),
        Product.product("Lifejacket", description:"Protective and fashionable",
        category:"Watersports", price:48.95, stock:0),
        Product.product("Soccer Ball", description:"FIFA-approved size and weight",
        category:"Soccer", price:19.5, stock:0),
        Product.product("Corner Flags",
        description:"Give your playing field a professional touch",
        category:"Soccer", price:34.95, stock:0),
        Product.product("Stadium", description:"Flat-packed 35,000-seat stadium",
        category:"Soccer", price:79500.0, stock:0),
        Product.product("Thinking Cap", description:"Improve your brain efficiency",
        category:"Chess", price:16.0, stock:0),
        Product.product("Unsteady Chair",
        description:"Secretly give your opponent a disadvantage",
        category: "Chess", price: 29.95, stock:0),
        Product.product("Human Chess Board", description:"A fun game for the family",
        category:"Chess", price:75.0, stock:0),
        Product.product("Bling-Bling King",
        description:"Gold-plated, diamond-studded King",
        category:"Chess", price:1200.0, stock:0)];
    
    // MARK: 
    // MARK: Life Cycle
    
    init() {
        self.networkQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        self.uiQueue = dispatch_get_main_queue();
    }
    
    // MARK:
    // MARK: Operations
    
    func loadData() -> [Product] {
        
        var decoratedProducts = [Product]();
        
        for product in self.productData {
            
            var product: Product = LowStockIncreaseDecorator(product: product);
            if (product.category == "Soccer") {
                product = SoccerDecreaseDecorator(product: product);
            }
            
            dispatch_async(self.networkQueue, { () -> Void in

                let stockConnection = NetworkPool.getConnection();
                let level = stockConnection.stockLevel(product.name);
            
                if (level != nil) {
                    product.stock = level!;
                    dispatch_async(self.uiQueue, { () -> Void in
                        if (self.callback != nil) {
                            self.callback!(product);
                        }
                    })
                }
            
                NetworkPool.pushConnection(stockConnection);
            });
            
            decoratedProducts.append(product);
        }
            
        return decoratedProducts;
    }
}



