//: Playground - noun: a place where people can play

import Cocoa
import Foundation;

var product = ("Kayak", "A boat for one person", "Watersports", 275.0, 10);

func writeDetailsWithProduct(product: (String, String, String, Double, Int)) {
    print("Name: \(product.0)");
    print("Description: \(product.1)");
}

writeDetailsWithProduct(product);