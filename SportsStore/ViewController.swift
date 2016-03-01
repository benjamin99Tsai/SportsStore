//
//  ViewController.swift
//  SportsStore
//
//  Created by Benjamin on 2/15/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import UIKit

var handler = { (product: Product) -> Void in
    print("Change \(product.name) \(product.stock) items in the stock");
}


// MARK: The TableViewCell for the Product Table

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    
    var product: Product?;
}


// MARK:
// MARK: The ViewController

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var stockTableView: UITableView!
    @IBOutlet weak var totalStockLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        displayTotal();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:
    // MARK: TableViewDataSource Related
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = products[indexPath.row];
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductTableViewCell;
        
        cell.nameLabel.text = product.name;
        cell.descriptionLabel.text = product.productDescription;
        cell.stockStepper.value = Double(product.stock);
        cell.stockField.text = String(product.stock);
        cell.product = self.products[indexPath.row];
        
        return cell;
    }
    
    // MARK:
    // MARK: TextField Related
    
    @IBAction func stockLevelDidChange(sender: AnyObject) {
        
        if var currentCell = sender as? UIView {
            while (true) {
                
                currentCell = currentCell.superview!;
                
                if let cell = currentCell as? ProductTableViewCell {
                    
                    if let product = cell.product {
                        
                        var newStockLevel: Int?;
                        
                        // try to get the latest stock lavel from the sender:
                        if let stepper = sender as? UIStepper {
                            
                            newStockLevel = Int(stepper.value);
                            
                        } else if let textField = sender as? UITextField {
                            
                            if let newValueText: String? = textField.text {
                                
                                if let newValue = Int(newValueText!) {
                                    newStockLevel = newValue;
                                }
                            }
                        }
                        
                        // update the UI to the latest stock level:
                        if let level = newStockLevel {
                            
                            product.stock = level;
                            cell.stockStepper.value = Double(level);
                            cell.stockField.text = String(level);
                            
                            logger.logItem(product);
                        }
                        
                        break;
                    }
                }
            }
            
            // update the total label:
            displayTotal();
        }
    }
    
    var products = [
        Product(name: "Kayak", description: "A boat for one person", category: "Watersports", price: 275, stock: 10),
        Product(name: "Lifejacket", description: "Protective and fashinable", category: "Watersports", price: 48.95, stock: 14),
        Product(name: "Soccer Ball", description: "FIFA-approved size and weight", category: "Soccer", price: 19.5, stock: 32),
        Product(name: "Corner Flags", description: "Give your playing field a professional touch", category: "Soccer", price: 34.95, stock: 1),
        Product(name: "Stadium", description: "Flat-packed 35,000-seat stadium", category: "Soccer", price: 79500.0, stock: 4),
        Product(name: "Thinking Cap", description: "Improve your brain efficiency by 75%", category:"Chess", price:16.0, stock: 8),
        Product(name: "Unsteady Chair", description: "Secretly give your opponent a disadvantage", category: "Chess", price: 29.95, stock: 3),
        Product(name: "Human Chess Board", description: "A fun game for the family", category: "Chess", price: 75.0, stock: 2),
        Product(name: "Bling-Bling King", description: "Gold-plated, diamond-studded King", category: "Chess", price:   1200.0, stock: 4)
    ];
    
    let logger = Logger<Product>(callback: handler);
    
    // MARK:
    // MARK: Utilities

    func calculateStockValue(products: [Product]) -> Double {
        
        return products.reduce(0, combine: { (total, product) -> Double in
            return total + product.stockValue;
        })
    }
    
    
    func displayTotal() {
            let totalCount = products.reduce(0, combine: {(total, product) -> Int in return total + product.stock})
            totalStockLabel.text = "\(totalCount) Products in Stock"
    }
    
}


