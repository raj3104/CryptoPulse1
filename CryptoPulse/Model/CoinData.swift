//
//  CoinData.swift
//  CryptoPulse
//
//  Created by user268740 on 1/12/25.
//

import UIKit
struct CoinData: Decodable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}

