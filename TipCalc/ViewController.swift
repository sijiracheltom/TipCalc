//
//  ViewController.swift
//  TipCalc
//
//  Created by Siji Rachel Tom on 8/13/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

func localCurrencyFormatter() -> NumberFormatter {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = NumberFormatter.Style.currency
    currencyFormatter.locale = Locale.current
    
    return currencyFormatter
}

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let currencyFormatter = localCurrencyFormatter()
    let currentLocale = Locale.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if last time bill value updated < 10mins ago
        // If so, update bill field with last saved bill value
        let lastBillValueUpdated = TimeInterval(readDefaults(LastUpdatedBillTimestampDefaultsKey))
        let lastBillValueUpdatedDate = Date.init(timeIntervalSinceReferenceDate: lastBillValueUpdated)
        let currentBillValueDuration = Date().timeIntervalSince(lastBillValueUpdatedDate)
        
        if currentBillValueDuration < kBillValueRefreshTimeout {
            let billValue = readDefaults(LastUpdatedBillValueDefaultsKey)
            billField.text = "\(billValue)"
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    }
    
    func appMovedToBackground() {
        // Save bill value and timestamp to user defaults
        let bill = Double(billField.text!) ?? 0
        writeDefaults(key: LastUpdatedBillValueDefaultsKey, value: bill)
        let now = Date().timeIntervalSinceReferenceDate
        writeDefaults(key: LastUpdatedBillTimestampDefaultsKey, value: now)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update segmented control to default saved value
        let selectedTipControlIndex = Int(readDefaults(TipPercentSelectedIndexDefaultsKey))
        // Set the user selected index to the segmentIndex
        tipControl.selectedSegmentIndex = selectedTipControlIndex
        
        // Calculate tip since the bill and the index is updated
        calculateTip(nil)
        
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func didEndEditing(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any?) {
        var tipPercentages = [0.18, 0.2, 0.25]
        tipPercentages.append(readDefaults(CustomTipPercentDefaultsKey))
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        let tipString = currencyFormatter.string(from: NSNumber.init(value: tip))
        let totalString = currencyFormatter.string(from: NSNumber.init(value: total))
        
        tipLabel.text = tipString
        totalLabel.text = totalString
    }
}

