//
//  TipCalcularDefines.swift
//  TipCalc
//
//  Created by Siji Rachel Tom on 8/13/17.
//  Copyright © 2017 Siji Rachel Tom. All rights reserved.
//

import UIKit

let CustomTipPercentDefaultsKey = "CustomTipPercent"
let TipPercentSelectedIndexDefaultsKey = "TipPercentSelectedIndex"
let LastUpdatedBillValueDefaultsKey = "LastUpdatedBillValue"
let LastUpdatedBillTimestampDefaultsKey = "LastUpdatedBillTimestamp"
let kBillValueRefreshTimeout = 10.0//*60.0 //10 minutes

let queue = DispatchQueue.init(label: "defaultsSerialQueue")

func writeDefaults(key: String, value: Double) {
    queue.async {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
}


func readDefaults(_ key: String) -> Double {
    var value = 0.0
    queue.sync {
        let defaults = UserDefaults.standard
        value = defaults.double(forKey: key)
    }
    
    return value
}
