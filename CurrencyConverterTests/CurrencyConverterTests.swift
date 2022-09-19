//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Macbook Pro on 13/9/22.
//  Copyright © 2022 Fahad Hasan Zahidi. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase {

    var vc:  ViewController!
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }

    override func tearDown() {
        super.tearDown()
        vc = nil
    }

    func test_validateResultData() {
        var currencyRates = [String:Double]()
        currencyRates["BDT"] = 94.1
        currencyRates["USD"] = 1.00
        let currencyListArray = ["BDT", "USD"];
        let currencyValueArray = ["94.1", "1"]
        let selectableCurrencyList = ["BDT", "USD"]
        vc.didFinishLoadData(currencyRates: currencyRates, selectableCurrencyList: selectableCurrencyList, currencyListArray: currencyListArray, currencyValueArray: currencyValueArray)
        XCTAssert(currencyValueArray.count == currencyListArray.count)
    }
    
    func test_updateItemsWithDouble() {
        let currentAmount = Double(vc.currencyValueArray[0])!
        vc.updateItems(amount: 2, selectedCurrency: "USD")
        let updatedAmount = Double(vc.currencyValueArray[0])!
        XCTAssert(currentAmount * 2 == updatedAmount)
    }
    
    func test_updateItemsWithZero() {
        vc.updateItems(amount: 0, selectedCurrency: "USD")
        let updatedAmount = Double(vc.currencyValueArray[0])!
        XCTAssert(0 == updatedAmount)
    }

    
}
