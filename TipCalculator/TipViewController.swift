//
//  ViewController.swift
//  TipCalculator
//
//  Created by LING HAO on 3/3/17.
//  Copyright © 2017 Blue Bambosa. All rights reserved.
//

import UIKit


class TipViewController: UIViewController {
    
    @IBOutlet var happyImage: UIImageView!
    @IBOutlet var sadImage: UIImageView!

    @IBOutlet var currencySymbol: UILabel!
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
        
        currencySymbol.text = Locale.current.currencySymbol
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
        
        if roundedValue >= percentSlider.maximumValue {
            animateImage(self.happyImage)
        }
        
        if roundedValue <= percentSlider.minimumValue {
            animateImage(self.sadImage)
        }
    }
    
    func animateImage(_ image: UIImageView) {
        let duration = 2.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.calculationModeLinear
        let fullRotation = CGFloat(M_PI * 2)
        
        UIView.animateKeyframes(withDuration: duration, delay: delay, options: options, animations: {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                // start at 0.00s (5s × 0)
                // duration 1.67s (5s × 1/3)
                // end at   1.67s (0.00s + 1.67s)
                image.transform = CGAffineTransform(rotationAngle: 1/3 * fullRotation)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                image.transform = CGAffineTransform(rotationAngle: 2/3 * fullRotation)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                image.transform = CGAffineTransform(rotationAngle: 3/3 * fullRotation)
            })
            
        }, completion: {finished in
        })
    }
    
    func updateTotal() {
        let percent = round(percentSlider.value) * 0.01
        let bill = Float(textField.text!) ?? 0
        let tip = Float(bill) * percent
        let sum = tip + bill
        
        let formatter = NumberFormatter()
        formatter.currencyCode = Locale.current.currencyCode
        formatter.numberStyle = .currency

        tipTextField.text = formatter.string(from: NSNumber(value: tip))
        totalTextField.text = formatter.string(from: NSNumber(value: sum))
    }
}

