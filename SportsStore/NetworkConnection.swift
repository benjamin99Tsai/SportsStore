//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by Benjamin on 3/1/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

class NetworkConnection {
    
    private let flyweight: NetworkFlyweight;
    
    init() {
        self.flyweight = NetworkFlyweightFactory.networkFlyweight();
    }
    
    func stockLevel(name: String) -> Int? {
        NSThread.sleepForTimeInterval(Double(rand() % 2));
        return self.flyweight.stock(name);
    }
}
