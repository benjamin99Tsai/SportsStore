//
//  Logger.swift
//  SportsStore
//
//  Created by Benjamin on 3/1/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

class Logger<T where T:NSObject, T:NSCopying> {
    var dataItems: [T] = [];
    var callback: T -> Void;
    
    init(callback: T -> Void) {
        self.callback = callback;
    }
    
    func logItem(item: T) {
        self.dataItems.append(item.copy() as! T);
        callback(item);
    }
    
    func processItems(callback: T -> Void) {
        for item in self.dataItems {
            callback(item);
        }
    }
}