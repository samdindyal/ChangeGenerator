//
//  ChangeGeneratorController.swift
//  ChangeGenerator
//
//  Created by Sam Dindyal on 2018-08-06.
//  Copyright © 2018 Sam Dindyal. All rights reserved.
//

import UIKit

class ChangeGeneratorController: UITableViewController {
    @IBOutlet var amountLabel:UITextField!
    
    var coins:[Coin]! {
        didSet {
            self.coins.sort { (a, b) -> Bool in
                a.quantity >= b.quantity && a.value >= b.value
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as! CoinCell
        
        let row = indexPath.row
        let coin = self.coins[row]
        cell.coinLabel.text = "\(coin.name)"
        cell.valueLabel.text = "$\(coin.value)"
        cell.amountLabel.text = "x\(coin.quantity)"
        
        return cell
    }
}
