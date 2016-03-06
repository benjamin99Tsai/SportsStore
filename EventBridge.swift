//
//  EventBridge.swift
//  SportsStore
//
//  Created by Benjamin on 3/6/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

class EventBridge {
    
    private let outputCallback: (String, Int) -> Void;
    
    init(callback: (String, Int) -> Void) {
        self.outputCallback = callback;
    }
    
    var inputCallback: (Product) -> Void {
        return { product in self.outputCallback(product.name, product.stock) };
    }
}
