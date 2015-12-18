//
//  SettingsViewController.swift
//  tips
//
//  Created by Anita on 12/4/15.
//  Copyright © 2015 Anita. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipField: UITextField!
    @IBOutlet weak var defaultTipSlider: UISlider!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Auto focus defaultTipField
        self.defaultTipField.becomeFirstResponder()
        
        let defaultTipPercent = defaults.stringForKey("defaultTip")
        
        if defaultTipPercent != nil {
            defaultTipField.text = defaultTipPercent
        } else {
            defaultTipField.text = "20"
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        defaultTipSlider.setValue(Float(defaults.stringForKey("defaultTip")!)!, animated: true)
        defaultTipField.text = String(format: "%.f", defaultTipSlider.value)
    }
    
    @IBAction func defaultTipSliderChanged(sender: AnyObject) {
        defaults.setObject(String(round(defaultTipSlider.value)), forKey: "defaultTip")
        defaults.synchronize()
        defaultTipField.text = String(format: "%.f", defaultTipSlider.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func defaultTipFieldChanged(sender: AnyObject) {
        let tipValue = Float(defaultTipField.text!)
        if tipValue != nil {
            defaultTipSlider.value = tipValue!
        } else {
            defaultTipSlider.value = 0.00
        }
        defaults.setObject(String(defaultTipSlider.value), forKey: "defaultTip")
        defaults.synchronize()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}
