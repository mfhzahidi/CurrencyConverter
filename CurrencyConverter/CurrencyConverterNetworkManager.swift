//
//  CurrencyConverterNetWorkManager.swift
//  CurrencyConverter
//
//  Created by Macbook Pro on 18/9/22.
//  Copyright © 2022 Fahad Hasan Zahidi. All rights reserved.
//

import Foundation

class CurrencyConverterNetworkManager {
    fileprivate let userDefaults = UserDefaults.standard
    fileprivate var currentTime = Date().timeIntervalSince1970
    fileprivate var currencyList: [String:String] = [String:String]()
    
    weak var presenterDelegate: InteractorToPresenterDelegate?
    
    func loadDataFromServer() {
        print("loadDataFromServer called")
        getCurrencies() { (json) in
            self.currencyList = json
            self.userDefaults.set(json, forKey: CurrencyConverterPageConstants.availableCurrencyList)
            print(self.currencyList)
        }
        getRates() { (json) in
            print(json.timestamp)
            print(json.base)
            print(json.rates)
            UserDefaults.standard .set(json.rates, forKey: CurrencyConverterPageConstants.downloadedRates)
            UserDefaults.standard.set(self.currentTime, forKey: CurrencyConverterPageConstants.lastDownloadTime)
            print("complete")
            self.presenterDelegate?.didFinishLoadData()
        }
    }
    
    fileprivate func getRates(completion: @escaping (CurrencyRateData)-> ()) {
        let urlString = CurrencyConverterPageConstants.getRatesURL
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {data, res, err in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let json: CurrencyRateData = try! decoder.decode(CurrencyRateData.self, from: data)
                        completion(json)
                    }catch let error {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
    
    fileprivate func getCurrencies(completion: @escaping ([String: String])-> ()) {
        let urlString = CurrencyConverterPageConstants.getCurrencyURL
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {data, res, err in
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!) as? [String:Any]{
                        completion(json as! [String:String])
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
    
    
}

