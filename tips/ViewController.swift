//
//  ViewController.swift
//  tips
//
//  Created by Anita on 12/4/15.
//  Copyright © 2015 Anita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var beneathBillField: UITextField!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tipControl.selectedSegmentIndex = 1
        billField.text = defaults.stringForKey("lastAmount")!
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        doCalculations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Do calculations for total price
    func doCalculations() {
        let defaultTipPercent = defaults.stringForKey("defaultTip")
        var tipPercent = 20.0
        if (defaultTipPercent != nil) {
            tipPercent = Double(defaultTipPercent!)!
        }
        var tipPercentages = [tipPercent - 2, tipPercent, tipPercent + 2]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex] / 100
        
        for i in 0...2 {
            tipControl.setTitle(String(format: "%.f%%", tipPercentages[i]), forSegmentAtIndex: i)
            if (tipPercent == 0) {
                tipControl.setTitle("0%", forSegmentAtIndex: i)
            }
        }
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = abs(billAmount * tipPercentage)
        let total = billAmount + tip
        
        defaults.setObject(billField.text, forKey: "lastAmount")
        defaults.synchronize()
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        doCalculations()
    }
    
    // Close keyboard when user taps elsewhere
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    

}

