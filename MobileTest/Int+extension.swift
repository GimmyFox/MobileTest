//
//  Int+extension.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 25.12.2023.
//

import Foundation

extension Int {
    func fromIntToPureString() -> String {
        return String(self).replacingOccurrences(of: " ", with: "")
    }
}
