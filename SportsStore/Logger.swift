//
//  Logger.swift
//  SportsStore
//
//  Created by Benjamin on 3/1/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

let productSharedLogger = Logger<Product> (callback: {p in
    print("Change \(p.name) \(p.stock) items in the stock");
});

final class Logger<T where T:NSObject, T:NSCopying> {
    
    // concurrency related queues:
    private let workQueue = dispatch_queue_create("LoggerQueue", DISPATCH_QUEUE_CONCURRENT);
    private let callbackQueue = dispatch_queue_create("callbackQueue", DISPATCH_QUEUE_SERIAL);
    
    // properties:
    var dataItems: [T] = [];
    var callback: T -> Void;
    
    // MARK:
    // MARK: Life Cycle
    
    private init(callback: T -> Void, protect: Bool = true) {
        
        self.callback = callback;
        
        if (protect) {
            
            self.callback = {(item: T) in
                dispatch_sync(self.callbackQueue, {() in
                    callback(item);
                });
            };
        }
    }
    
    
    // MARK:
    // MARK: Processes
    
    func logItem(item: T) {
        dispatch_barrier_async(self.workQueue) { () -> Void in
            self.dataItems.append(item.copy() as! T);
            self.callback(item);
        }
    }
    
    func processItems(callback: T -> Void) {
        dispatch_sync(self.workQueue, {() in
            for item in self.dataItems {
                callback(item);
            }
        });
    }
}