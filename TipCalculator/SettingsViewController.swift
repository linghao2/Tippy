//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by LING HAO on 3/3/17.
//  Copyright © 2017 Blue Bambosa. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet var minimumLabel: UILabel!
    @IBOutlet var minimumStepper: UIStepper!
    
    @IBOutlet var maximumLabel: UILabel!
    @IBOutlet var maximumStepper: UIStepper!
        
    static let MINIMUM_PERCENT = "MimimumPercent"
    static let MAXIMUM_PERCENT = "MaximumPercent"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.init()
        if (defaults.object(forKey: SettingsViewController.MINIMUM_PERCENT) != nil) {
            let minPercent = defaults.double(forKey: SettingsViewController.MINIMUM_PERCENT)
            minimumStepper.value = minPercent
            setMinimumPercent(minPercent)
        }

        if (defaults.object(forKey: SettingsViewController.MAXIMUM_PERCENT) != nil) {
            let maxPercent = defaults.double(forKey: SettingsViewController.MAXIMUM_PERCENT)
            maximumStepper.value = maxPercent
            setMaximumPercent(maxPercent)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: minimum and maximum stepper

    @IBAction func minimumChanged(_ sender: UIStepper) {
        setMinimumPercent(sender.value)
        
        let defaults = UserDefaults.init()
        defaults.set(sender.value, forKey: SettingsViewController.MINIMUM_PERCENT)
    }
    
    func setMinimumPercent(_ minPercent: Double) {
        let intValue = Int(minPercent)
        minimumLabel.text = "\(intValue)%"
        maximumStepper.minimumValue = minPercent
    }
    
    @IBAction func maximumChanged(_ sender: UIStepper) {
        setMaximumPercent(sender.value)
        
        let defaults = UserDefaults.init()
        defaults.set(sender.value, forKey: SettingsViewController.MAXIMUM_PERCENT)
    }
    
    func setMaximumPercent(_ maxPercent: Double) {
        let intValue = Int(maxPercent)
        maximumLabel.text = "\(intValue)%"
        minimumStepper.maximumValue = maxPercent
    }
    
}
