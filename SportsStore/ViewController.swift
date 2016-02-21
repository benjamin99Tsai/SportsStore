//
//  ViewController.swift
//  SportsStore
//
//  Created by Benjamin on 2/15/16.
//  Copyright © 2016 Apress. All rights reserved.
//

import UIKit


class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
}


class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var stockTableView: UITableView!
    @IBOutlet weak var totalStockLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTotal();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = products[indexPath.row];
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductTableViewCell;
        
        cell.nameLabel.text = product.0;
        cell.descriptionLabel.text = product.1;
        cell.stockStepper.value = Double(product.3);
        cell.stockField.text = String(product.4);
        
        return cell;
    }

    var products = [
        ("Kayak", "A boat for one person", "Watersports", 275.0, 10),
        ("Lifejacket", "Protective and fashionable", "Watersports", 48.95, 14),
        ("Soccer Ball", "FIFA-approved size and weight", "Soccer", 19.5, 32),
        ("Corner Flags", "Give your playing field a professional touch", "Soccer", 34.95, 1),
        ("Stadium", "Flat-packed 35,000-seat stadium", "Soccer", 79500.0, 4),
        ("Thinking Cap", "Improve your brain efficiency by 75%", "Chess", 16.0, 8),
        ("Unsteady Chair", "Secretly give your opponent a disadvantage", "Chess", 29.95, 3),
        ("Human Chess Board", "A fun game for the family", "Chess", 75.0, 2),
        ("Bling-Bling King", "Gold-plated, diamond-studded King", "Chess", 1200.0, 4)
    ];
    
    func displayTotal() {
            let totalCount = products.reduce(0, combine: {(total, product) -> Int in return total + product.4})
            totalStockLabel.text = "\(totalCount) Products in Stock"
    }
}


