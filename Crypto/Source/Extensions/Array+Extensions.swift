//
//  Array+Extensions.swift
//  Crypto
//
//  Created by chandru on 07/03/24.
//

import Foundation

extension Array {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
