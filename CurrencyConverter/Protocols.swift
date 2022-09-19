//
//  Protocols.swift
//  CurrencyConverter
//
//  Created by Macbook Pro on 19/9/22.
//  Copyright © 2022 Fahad Hasan Zahidi. All rights reserved.
//

import Foundation


protocol PresenterToViewDelegate: class {
    func didFinishLoadData(currencyRates: [String:Double], selectableCurrencyList: [String], currencyListArray: [String], currencyValueArray: [String])
}

protocol InteractorToPresenterDelegate: class {
    func didFinishLoadData()
}
