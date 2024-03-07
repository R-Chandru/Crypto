//
//  CryptoListEntity.swift
//  Crypto
//
//  Created by chandru on 06/03/24.
//

import Foundation

struct CryptoResponse: Codable {
    let cryptocurrencies: [CryptoCurrency]
}

struct CryptoCurrency: Codable {
    let name: String
    let symbol: String
    let isNew: Bool
    let isActive: Bool
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case name, symbol, isNew = "is_new", isActive = "is_active", type
    }
}

enum CryptoCoinType {
    case activeCoins
    case inactiveCoins
    case onlyTokens
    case onlyCoins
    case newCoins
}
