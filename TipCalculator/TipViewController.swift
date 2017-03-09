//
//  ViewController.swift
//  TipCalculator
//
//  Created by LING HAO on 3/3/17.
//  Copyright © 2017 Blue Bambosa. All rights reserved.
//

import UIKit


class TipViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    @IBOutlet var totalTextField: UILabel!
    @IBOutlet var tipTextField: UILabel!
    @IBOutlet var percentLabel: UILabel!
    @IBOutlet var percentSlider: UISlider!
    
    static let BILL_AMOUNT = "BILL_AMOUNT"
    let PERCENT = "Percent"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.init()
        if (defaults.object(forKey: TipViewController.BILL_AMOUNT) != nil) {
            let bill = defaults.string(forKey: TipViewController.BILL_AMOUNT)
            textField.text = bill
            updateTotal()
        }
        textField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.init()
        if (defaults.object(forKey: SettingsViewController.MINIMUM_PERCENT) != nil) {
            let minPercent = defaults.float(forKey: SettingsViewController.MINIMUM_PERCENT)
            percentSlider.minimumValue = minPercent
        }
        
        if (defaults.object(forKey: SettingsViewController.MAXIMUM_PERCENT) != nil) {
            let maxPercent = defaults.float(forKey: SettingsViewController.MAXIMUM_PERCENT)
            percentSlider.maximumValue = maxPercent
        }
        if (defaults.object(forKey: PERCENT) != nil) {
            let percent = defaults.float(forKey: PERCENT)
            percentSlider.value = percent
        }
        let roundedValue = round(percentSlider.value)
        let intValue = Int(roundedValue)
        percentLabel.text = "Service (\(intValue)%)"
        updateTotal()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func textFieldChanged(_ sender: Any) {
        let defaults = UserDefaults.init()
        defaults.set(textField.text, forKey: TipViewController.BILL_AMOUNT)

        updateTotal()
    }
    
    @IBAction func percentChanged(_ sender: Any) {
        let roundedValue = round(percentSlider.value)
        let intValue = Int(roundedValue)
        percentLabel.text = "Service (\(intValue)%)"
        updateTotal()
        
        let defaults = UserDefaults.init()
        defaults.set(roundedValue, forKey: PERCENT)
    }
    
    func updateTotal() {
        let percent = round(percentSlider.value) * 0.01
        let bill = Float(textField.text!) ?? 0
        let tip = Float(bill) * percent
        let sum = tip + bill
        tipTextField.text = String(format: "$%.2f", tip)
        totalTextField.text = String(format: "$%.2f", sum)
    }
}

