//
//  NetworkPool.swift
//  SportsStore
//
//  Created by Benjamin on 3/1/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation

final class NetworkPool {
    
    // The singleton instance
    static let sharedPool = NetworkPool();
    
    // Properties
    private let connectionCount = 3;
    private var connections = [NetworkConnection]();
    private var semaphore: dispatch_semaphore_t;
    private var queue: dispatch_queue_t;
    
    // MARK:
    // MARK: Life Cycle
    
    private init() {
        for _ in 0 ..< self.connectionCount {
            self.connections.append(NetworkConnection());
        }
        
        self.semaphore = dispatch_semaphore_create(self.connectionCount);
        self.queue = dispatch_queue_create("NetworkPoolQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    
    // MARK:
    // MARK: Operations
    
    func getConnection() -> NetworkConnection {
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        
        var connection: NetworkConnection? = nil;
        dispatch_sync(self.queue, { () -> Void in
            connection = self.connections.removeAtIndex(0);
        });
        
        return connection!;
    }
    
    class func getConnection() -> NetworkConnection {
        return self.sharedPool.getConnection();
    }
    
    func pushConnection(connection: NetworkConnection) {
        dispatch_async(self.queue, {() in
            self.connections.append(connection);
            dispatch_semaphore_signal(self.semaphore);
        });
    }
    
    class func pushConnection(connection: NetworkConnection) {
        self.sharedPool.pushConnection(connection);
    }
}