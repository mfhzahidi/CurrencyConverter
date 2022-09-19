//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Macbook Pro on 16/9/22.
//  Copyright © 2022 Fahad Hasan Zahidi. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    //MARK: outlets
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var currencyField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: variables
    var currencyRates: [String:Double] = [String:Double]()
    var selectableCurrencyList: [String] = [String]()
    var currencyListArray: [String] = [String]()
    var currencyValueArray: [String] = [String]()
    let numberOfItemsPerRow = CurrencyConverterPageConstants.numberOfItemsPerRow
    
    var currencyConverterPresenter: CurrencyConverterPresenter = CurrencyConverterPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.isHidden = true
        collectionView.alpha = CurrencyConverterPageConstants.setAplhaFull
        hideKeyboardWhenTappedAround()
        registerCell()
        currencyConverterPresenter.vcDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear called")
        collectionView.reloadData()
        currencyConverterPresenter.loadData()
    }
    
    fileprivate func registerCell() {
        print("viewWillAppear called")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CurrencyConverterPageConstants.collectionViewCellInitialSize, height: CurrencyConverterPageConstants.collectionViewCellInitialSize)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(CurrencyValueCollectionViewCell.loadNib(), forCellWithReuseIdentifier: CurrencyValueCollectionViewCell.cellReuseId)
    }
    
    fileprivate func updateUIWithData() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.collectionView.reloadData()
        })
    }
    
    @IBAction func convertButtonTapped(_ sender: Any) {
        let amount = Double(amountField.text ?? "")
        if amount == nil {
            return
        }
        var selectedCurrency = currencyField.text
        if selectedCurrency == nil || selectedCurrency == ""{
            return
        }
        selectedCurrency = String(selectedCurrency!.suffix(3))
        updateItems(amount: Double(amount!), selectedCurrency: selectedCurrency!)
    }
    
    func updateItems(amount: Double, selectedCurrency: String) {
        
        print(amount as Any)
        print(selectedCurrency as Any)
        currencyValueArray.removeAll()
        let usdValue = amount / currencyRates[selectedCurrency]!
        for key in currencyListArray {
            let localValue = usdValue * currencyRates[key]!
            currencyValueArray.append(String(localValue))
        }
        collectionView.reloadData()
    }
    

}


extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return CurrencyConverterPageConstants.pickerViewComponent
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectableCurrencyList.count
    }
    
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        view.endEditing(true)
        return selectableCurrencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyField.text = selectableCurrencyList[row]
        pickerView.isHidden = true
        collectionView.alpha = CurrencyConverterPageConstants.setAplhaFull
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == currencyField) {
            pickerView.isHidden = false
            collectionView.alpha = CurrencyConverterPageConstants.setAlphaDim
            currencyField.endEditing(true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CurrencyConverterPageConstants.collectionViewNumberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencyListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyValueCollectionViewCell.cellReuseId, for: indexPath) as! CurrencyValueCollectionViewCell
        cell.configure(name: currencyListArray[indexPath.row], value: Double(currencyValueArray[indexPath.row])!)
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        return CGSize(width: size, height: size)
    }
}

extension ViewController: PresenterToViewDelegate {
    func didFinishLoadData(currencyRates: [String:Double], selectableCurrencyList: [String], currencyListArray: [String], currencyValueArray: [String]) {
        self.currencyRates = currencyRates
        self.selectableCurrencyList = selectableCurrencyList
        self.currencyListArray = currencyListArray
        self.currencyValueArray = currencyValueArray
        
        self.updateUIWithData()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

