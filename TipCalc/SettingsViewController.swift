//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Siji Rachel Tom on 8/13/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

enum TipControlSelection : Int {
    case eighteenPercent = 0
    case twentyPercent
    case twentyFivePercent
    case customPercent
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var customTipField: UITextField!
    @IBOutlet weak var customTipLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let selectedTipPercentIndex = Int(readDefaults(TipPercentSelectedIndexDefaultsKey))
        tipControl.selectedSegmentIndex = selectedTipPercentIndex
        enableCustomPercentControlsIfRequired(selectedTipPercentIndex: selectedTipPercentIndex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Make sure to save custom tip percent since it seems like the main ViewController
        // is presented before the custom tip field did end editing callback is received
        saveCustomTipPercentIfRequired()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    @IBAction func customTipPercentEntered(_ sender: Any) {
        saveCustomTipPercentIfRequired()
    }
    
    @IBAction func tipControlValueChanged(_ sender: Any) {
        let selectedTipPercentIndex = tipControl.selectedSegmentIndex
        // Update user defaults - selected tip index
        writeDefaults(key: TipPercentSelectedIndexDefaultsKey, value: Double(selectedTipPercentIndex))
        enableCustomPercentControlsIfRequired(selectedTipPercentIndex: selectedTipPercentIndex)
    }
    
    @IBAction func didTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    func saveCustomTipPercentIfRequired() {
        let selectedTipPercentIndex = tipControl.selectedSegmentIndex
        if (selectedTipPercentIndex == TipControlSelection.customPercent.rawValue) {
            let customTimPercentage = (Double(customTipField.text!) ?? 0) * 0.01
            writeDefaults(key: CustomTipPercentDefaultsKey, value: customTimPercentage)
        }
    }
    
    /// Show/hide custom tip entry controls
    func enableCustomPercentControlsIfRequired(selectedTipPercentIndex: Int) {
        if selectedTipPercentIndex == TipControlSelection.customPercent.rawValue {
            // if it's the custom tip selected, show tip entry fields
            let customTipValue = readDefaults(CustomTipPercentDefaultsKey) * 100
            customTipField.text = "\(customTipValue)"
            setCustomPercentControlsHidden(hide: false)
            customTipField.becomeFirstResponder()
        } else {
            setCustomPercentControlsHidden(hide: true)
            customTipField.resignFirstResponder()
        }
    }    
    
    func setCustomPercentControlsHidden(hide: Bool) {
        UIView.animate(withDuration: 0.4) {
            [weak self] in            
            let alpha = CGFloat(hide ? 0.0 : 1.0)
            self?.customTipLabel.alpha = alpha;
            self?.customTipField.alpha = alpha;
        }
    }
}
