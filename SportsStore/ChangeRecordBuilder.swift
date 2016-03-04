//
//  ChangeRecordBuilder.swift
//  SportsStore
//
//  Created by Benjamin on 3/4/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import Foundation


// MARK:
// MARK: ChangeRecord Class

class ChangeRecord : CustomStringConvertible {
    
    private let outerTag: String;
    private let productName: String;
    private let categoryName: String;
    private let innerTag: String;
    private let value: String;
    
    private init(outer: String, name: String, category: String, inner: String, value: String) {
        self.outerTag = outer;
        self.productName = name;
        self.categoryName = category;
        self.innerTag = inner;
        self.value = value;
    }
    
    var description : String {
        return "<\(self.outerTag)><\(self.innerTag) name: \"\(self.productName)\""
            + " category: \"\(self.categoryName)\"> \(self.value) <\(self.innerTag)><\(self.outerTag)>"
    }
    
}


// MARK:
// MARK: ChangeRecord Builder

class ChangeRecordBuilder {
    
    var outerTag: String;
    var innerTag: String;
    var productName: String?;
    var categoryName: String?;
    var value: String?;
    
    init() {
        outerTag = "change";
        innerTag = "product";
    }
    
    var changeRecord : ChangeRecord? {
        get {
            if (self.productName != nil && self.categoryName != nil && value != nil) {
                
                return ChangeRecord(
                    outer: self.outerTag,
                    name: self.productName!,
                    category: self.categoryName!,
                    inner: self.innerTag,
                    value: self.value!);
                
            } else {
                return nil;
            }
        }
    }
}