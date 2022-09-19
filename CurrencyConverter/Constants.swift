//
//  Constants.swift
//  CurrencyConverter
//
//  Created by Macbook Pro on 18/9/22.
//  Copyright © 2022 Fahad Hasan Zahidi. All rights reserved.
//

import Foundation
import UIKit

struct CurrencyRateData: Codable {
    let base: String
    let timestamp: Int
    let rates: [String:Float]
}


class CurrencyConverterPageConstants {
    //MARK: UI Constants
    static let setAplhaFull: CGFloat = 1.0
    static let setAlphaDim: CGFloat = 0.1
    static let numberOfItemsPerRow = 3
    static let pickerViewComponent = 1
    static let collectionViewNumberOfSections  = 1
    static let collectionViewCellInitialSize = 120
    
    //MARK: Keys
    static let availableCurrencyList = "avialableCurrenciyList"
    static let lastDownloadTime = "lastDownloadTime"
    static let downloadedRates = "downloadedCurrencyRates"
    
    //MARK: Basic
    static let minutesInAnHour: Double = 60.0
    
    //MARK: Required
    static let requiredMinutesToCheck: Double  = 30.0
    
    static let getRatesURL = "https://openexchangerates.org/api/latest.json?app_id=fa0727a75c944d4485a09473cbf6277e"
    static let getCurrencyURL = "https://openexchangerates.org/api/currencies.json?app_id=fa0727a75c944d4485a09473cbf6277e"
}

