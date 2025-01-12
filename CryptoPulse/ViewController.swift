//
//  ViewController.swift
//  CryptoPulse
//
//  Created by user268740 on 1/12/25.
//

import UIKit


class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, coinManagerdelegate {
    
    
    @IBOutlet weak var coin: UIImageView!
    var selectedCrypto="BTC"
    var selectedCurrency="AUD"
    func didUpdatePrice(amount: String, currency: String,coin:String) {
        DispatchQueue.main.async {
            self.bitcoinAmount.text=amount
            self.countryCurrency.text=currency
            self.coin.image=UIImage(imageLiteralResourceName: self.selectedCrypto)
        }
      
    }
    
    func didFailWithError(error: any Error) {
        print(error)
        
    }
    
    var coinmanager=CoinManager()
    @objc(numberOfComponentsInPickerView:) func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    @objc func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component==0{
            return coinmanager.cryptoCurrency.count
        }
        else{
            return coinmanager.currencyArray.count
        }
        
    
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return coinmanager.cryptoCurrency[row] // Use cryptoCurrency for the first component
        } else {
            return coinmanager.currencyArray[row] // Use currencyArray for the second component
        }
    }

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource=self
        coinmanager.delegate=self
        
        currencyPicker.selectRow(0, inComponent: 0, animated: false) // Default to first cryptocurrency (BTC)
                currencyPicker.selectRow(0, inComponent: 1, animated: false) // Default to first currency (AUD)
                
                // Initialize selected values
                selectedCrypto = coinmanager.cryptoCurrency[0]
                selectedCurrency = coinmanager.currencyArray[0]
        currencyPicker.delegate=self
        coinmanager.getCoinPrice(for: selectedCurrency, crypto: selectedCrypto)
        // Do any additional setup after loading the view.
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           if component == 0 {
               // Update the selected cryptocurrency
               selectedCrypto = coinmanager.cryptoCurrency[row]
           } else {
               // Update the selected currency
               selectedCurrency = coinmanager.currencyArray[row]
           }
           
           // Fetch price based on the selected values
           coinmanager.getCoinPrice(for: selectedCurrency, crypto: selectedCrypto)
       }


    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var countryCurrency: UILabel!
    @IBOutlet weak var bitcoinAmount: UILabel!
}

