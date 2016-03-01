//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by Benjamin on 3/1/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

class NetworkConnection {
    
    private let stockData: [String: Int] = [
        "Kayak" : 10,
        "Lifejacket": 14,
        "Soccer Ball": 32,
        "Corner Flags": 1,
        "Stadium": 4,
        "Thinking Cap": 8,
        "Unsteady Chair": 3,
        "Human Chess Board": 2,
        "Bling-Bling King":4
    ];
    
    func stockLevel(name: String) -> Int? {
        NSThread.sleepForTimeInterval(Double(rand() % 2));
        return self.stockData[name];
    }
}
