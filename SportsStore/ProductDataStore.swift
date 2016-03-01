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
        Product(name:"Kayak", description:"A boat for one person",
        category:"Watersports", price:275.0, stock:0),
        Product(name:"Lifejacket", description:"Protective and fashionable",
        category:"Watersports", price:48.95, stock:0),
        Product(name:"Soccer Ball", description:"FIFA-approved size and weight",
        category:"Soccer", price:19.5, stock:0),
        Product(name:"Corner Flags",
        description:"Give your playing field a professional touch",
        category:"Soccer", price:34.95, stock:0),
        Product(name:"Stadium", description:"Flat-packed 35,000-seat stadium",
        category:"Soccer", price:79500.0, stock:0),
        Product(name:"Thinking Cap", description:"Improve your brain efficiency",
        category:"Chess", price:16.0, stock:0),
        Product(name:"Unsteady Chair",
        description:"Secretly give your opponent a disadvantage",
        category: "Chess", price: 29.95, stock:0),
        Product(name:"Human Chess Board", description:"A fun game for the family",
        category:"Chess", price:75.0, stock:0),
        Product(name:"Bling-Bling King",
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
        for product in self.productData {
            
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
        }
            
        return self.productData;
    }
}



