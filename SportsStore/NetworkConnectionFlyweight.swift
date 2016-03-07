//
//  NetworkConnectionFlyweight.swift
//  SportsStore
//
//  Created by Benjamin on 3/7/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation


// MARK:
// MARK: The Flyweight Protocol for Network Connections

protocol NetworkFlyweight {
    func stock(name: String) -> Int?;
}


// MARK:
// MARK: The Implementation of the NetworkFlyweight

class NetworkFlyweightImplementation : NetworkFlyweight {
    
    private let extrinsicData: [String: Int];
    
    private init(extrinsicData: [String: Int]) {
        self.extrinsicData = extrinsicData;
    }
    
    func stock(name: String) -> Int? {
        return self.extrinsicData[name];
    }
}


// MARK:
// MARK: The Corresponding Factory for the Network Flyweight

class NetworkFlyweightFactory {
    
    class func networkFlyweight() -> NetworkFlyweight {
        return NetworkFlyweightImplementation(extrinsicData: extrinsicData);
    }
    
    private static var extrinsicData: [String: Int] = [
        "Kayak" : 10,
        "Lifejacket": 14,
        "Soccer Ball": 32,
        "Corner Flags": 1,
        "Stadium": 4,
        "Thinking Cap": 8,
        "Unsteady Chair": 3,
        "Human Chess Board": 2,
        "Bling-Bling King":4];
}



