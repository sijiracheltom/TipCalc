//
//  ViewController.swift
//  TipCalc
//
//  Created by Siji Rachel Tom on 8/13/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update segmented control if required
        let selectedTipControlIndex = Int(readDefaults(TipPercentSelectedIndexDefaultsKey))
        // Select user selected index
        tipControl.selectedSegmentIndex = selectedTipControlIndex
        
        calculateTip(nil)
    }
    
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    
    @IBAction func calculateTip(_ sender: Any?) {
        var tipPercentages = [0.18, 0.2, 0.25]
        tipPercentages.append(readDefaults(CustomTipPercentDefaultsKey))
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%0.2f", tip)
        totalLabel.text = String(format: "$%0.2f", arguments: [total])
    }
}

