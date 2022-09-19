//
//  CurrencyConverterManager.swift
//  CurrencyConverter
//
//  Created by Macbook Pro on 18/9/22.
//  Copyright © 2022 Fahad Hasan Zahidi. All rights reserved.
//

import Foundation


class CurrencyConverterPresenter {
    fileprivate let userDefaults = UserDefaults.standard
    fileprivate var currentTime = Date().timeIntervalSince1970
    fileprivate var currencyList: [String:String] = [String:String]()
    fileprivate var currencyRates: [String:Double] = [String:Double]()
    fileprivate var selectableCurrencyList: [String] = [String]()
    fileprivate var currencyListArray: [String] = [String]()
    fileprivate var currencyValueArray: [String] = [String]()
    
    weak var vcDelegate: PresenterToViewDelegate?
    var networkManager: CurrencyConverterNetworkManager = CurrencyConverterNetworkManager()
    
    init() {
        networkManager.presenterDelegate = self
    }
    
    func loadData() {
        print("loadData called")
        if (userDefaults.value(forKey: CurrencyConverterPageConstants.availableCurrencyList) != nil) {
            let lastTime = userDefaults.value(forKey: CurrencyConverterPageConstants.lastDownloadTime)
            let lastLoadTime = lastTime as! Double
            currentTime = Date().timeIntervalSince1970
            if((currentTime - lastLoadTime)/CurrencyConverterPageConstants.minutesInAnHour > CurrencyConverterPageConstants.requiredMinutesToCheck ) {
                networkManager.loadDataFromServer()
            }
        }
        else {
            networkManager.loadDataFromServer()
        }
        
        loadLocalData()
        vcDelegate?.didFinishLoadData(currencyRates: currencyRates, selectableCurrencyList: selectableCurrencyList, currencyListArray: currencyListArray, currencyValueArray: currencyValueArray)
        
    }
    
    fileprivate func updatePresenterData() {
        loadLocalData()
        vcDelegate?.didFinishLoadData(currencyRates: currencyRates, selectableCurrencyList: selectableCurrencyList, currencyListArray: currencyListArray, currencyValueArray: currencyValueArray)
    }
    
    fileprivate func loadLocalData() {
        if (userDefaults.value(forKey: CurrencyConverterPageConstants.availableCurrencyList) == nil) {
            return
        }
        currencyList = userDefaults.value(forKey: CurrencyConverterPageConstants.availableCurrencyList) as! [String : String]
        for currency in currencyList {
            selectableCurrencyList.append(currency.value + " " + currency.key)
        }
        selectableCurrencyList.sort()
        
        currencyRates = userDefaults.value(forKey: CurrencyConverterPageConstants.downloadedRates) as! [String:Double]
        
        for currency in currencyRates {
            currencyListArray.append(currency.key)
        }
        
        currencyListArray.sort()
        for key in currencyListArray {
            currencyValueArray.append(String(currencyRates[key]!))
        }
        
    }
    
    
}

extension CurrencyConverterPresenter: InteractorToPresenterDelegate {
    func didFinishLoadData() {
        updatePresenterData()
    }
    
}
