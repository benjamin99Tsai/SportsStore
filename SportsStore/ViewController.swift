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
    
    let logger = productSharedLogger;
    var productStore = ProductDataStore();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        displayTotal();
        
        let eventBridge = EventBridge(callback: self.updateStockLevel);
        self.productStore.callback = eventBridge.inputCallback;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:
    // MARK: TableViewDataSource Related
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productStore.products.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = self.productStore.products[indexPath.row];
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductTableViewCell;
        
        cell.nameLabel.text = product.name;
        cell.descriptionLabel.text = product.productDescription;
        cell.stockStepper.value = Double(product.stock);
        cell.stockField.text = String(product.stock);
        cell.product = self.productStore.products[indexPath.row];
        
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
                            
                            self.logger.logItem(product);
                        }
                        
                        break;
                    }
                }
            }
            
            // update the total label:
            displayTotal();
        }
    }
    
    // MARK:
    // MARK: Utilities

    func calculateStockValue(products: [Product]) -> Double {
        
        return products.reduce(0, combine: { (total, product) -> Double in
            return total + product.stockValue;
        })
    }
    
    
    func displayTotal() {
        let totals:(Int, Double) = self.productStore.products.reduce((0, 0.0)) { (totals, product) -> (Int, Double) in
            return (
                totals.0 + product.stock,
                totals.1 + product.stockValue
            );
        }
        
        let formatted = StockTotalFacade.formatCurrencyAmount(totals.1, currency: StockTotalFacade.Currency.USD);
        
        totalStockLabel.text = "\(totals.0) Products in Stock. Total Value: \(formatted ?? "None" )";
    }
    
    func updateStockLevel(name: String, level: Int) {
        
        for cell in self.stockTableView.visibleCells {
            if let productCell = cell as? ProductTableViewCell {
                if productCell.product?.name == name {
                    productCell.stockField.text = String(level);
                    productCell.stockStepper.value = Double(level);
                }
            }
            
            self.displayTotal();
        }
    }
    
}


