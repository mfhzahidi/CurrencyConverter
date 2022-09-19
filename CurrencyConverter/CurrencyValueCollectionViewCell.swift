//
//  CurrencyValueCollectionViewCell.swift
//  CurrencyConverter
//
//  Created by Macbook Pro on 14/9/22.
//  Copyright © 2022 Fahad Hasan Zahidi. All rights reserved.
//

import UIKit

class CurrencyValueCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func loadNib() -> UINib{
        return UINib(nibName: "CurrencyValueCollectionViewCell", bundle: nil)
    }
    
    static let cellReuseId = "CurrencyValueCollectionViewCell"
    
    func configure(name: String, value: Double) {
        currencyName.text = name
        currencyValue.text = String(value)
    }

}
