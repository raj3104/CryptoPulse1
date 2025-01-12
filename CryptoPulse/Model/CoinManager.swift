//
//  CoinManager.swift
//  CryptoPulse
//
//  Created by user268740 on 1/12/25.
//

import Foundation
protocol coinManagerdelegate {
    func didUpdatePrice(amount:String, currency:String,coin:String)
    func didFailWithError(error:Error)
}

struct CoinManager {
    var delegate:coinManagerdelegate?
    let baseUrl="https://rest.coinapi.io/v1/exchangerate/"
    
    let apiKey="1ED5E67A-61A1-47C2-BD14-F17BB91F78B6"
    
    let currencyArray=["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let cryptoCurrency = [
        "BTC",  // Bitcoin
        "ETH",  // Ethereum
        "USDT", // Tether
        "BNB",  // Binance Coin
        "XRP",  // XRP (Ripple)
        "USDC", // USD Coin
        "ADA",  // Cardano
        "DOGE", // Dogecoin
        "SOL",  // Solana
        "TRX",  // TRON
        "DOT",  // Polkadot
        "MATIC", // Polygon
        "LTC",  // Litecoin
        "SHIB", // Shiba Inu
        "AVAX", // Avalanche
        "UNI",  // Uniswap
        "WBTC", // Wrapped Bitcoin
        "LINK", // Chainlink
        "ATOM", // Cosmos
        "XMR",  // Monero
        "BCH",  // Bitcoin Cash
        "APT",  // Aptos
        "TON",  // Toncoin
        "ETC",  // Ethereum Classic
        "XLM",  // Stellar
        "NEAR", // NEAR Protocol
        "ALGO", // Algorand
        "HBAR", // Hedera
        "VET",  // VeChain
        "FIL"   // Filecoin
    ]

    
    func getCoinPrice(for currency: String, crypto: String){
        let urlString="\(baseUrl)\(crypto)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        
        if let url=URL(string:urlString){
            let session=URLSession(configuration: .default)
            let task=session.dataTask(with: url){(data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData=data{
                    if let bitcoinPrice=self.parseJSON(safeData){
                        let priceString=String(format: "%.2f", bitcoinPrice)
                        print(priceString)
                        self.delegate?.didUpdatePrice(amount: priceString, currency: currency,coin: crypto)
                    }
                }
                
            }
            task.resume()
            
            
            
            
        }
        
        
        
        
    }
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            print("Rate: \(lastPrice)")
            print("Base Asset: \(decodedData.asset_id_base)")
            print("Quote Asset: \(decodedData.asset_id_quote)")
            return lastPrice
        } catch {
            delegate?.didFailWithError(error: error)
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }

}

