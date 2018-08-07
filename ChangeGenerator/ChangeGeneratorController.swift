//
//  ChangeGeneratorController.swift
//  ChangeGenerator
//
//  Created by Sam Dindyal on 2018-08-06.
//  Copyright © 2018 Sam Dindyal. All rights reserved.
//

import UIKit

class ChangeGeneratorController: UITableViewController, UITextFieldDelegate {
    @IBOutlet var amountLabel:UITextField!
    
    @IBAction func amountChanged(_ sender: UITextField) {
        if let change = Float(self.amountLabel.text!) {
            self.change = change
            calculateCoinQuantites()
        }
    }
    
    var coins:[Coin]! {
        didSet {
            self.coins.sort { (a, b) -> Bool in
                a.quantity >= b.quantity && a.value >= b.value
            }
        }
    }
    
    var change:Float!
    var numberFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
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
        
        cell.editingAccessoryType = coin.active ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]
        coin.active = !coin.active
        calculateCoinQuantites()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]
        cell.accessoryType = coin.active ? .checkmark : .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        amountLabel.text = numberFormatter.string(from: NSNumber(value: self.change))
        calculateCoinQuantites()
    }
    
    
    func calculateCoinQuantites() {
        if var change = self.change {
        
            for coin in coins {
                coin.quantity = 0
                if coin.active,
                    change >= coin.value {
                    coin.quantity = Int(change/coin.value)
                    
                    // Force round to resolve rounding errors
                    change -= coin.value * Float(coin.quantity)
                    change = (round(change*100))/100.0

                }
            }
            
            tableView.reloadData()
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let existingTextHasSeparator = textField.text?.range(of: ".")
        let replacementTextHasSeparator = string.range(of: ".")
        
        return existingTextHasSeparator == nil || replacementTextHasSeparator == nil
    }
}
