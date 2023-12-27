//
//  String+extension.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 22.12.2023.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "([A-Za-z0-9]+[.\\-_])*[A-Za-z0-9]+@[A-Za-z0-9-]+(\\.[A-Z|a-z]{2,})+"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: self)
    }
    
    
    func formatPhone(pattern: String, replacing: Character) -> String {
        let cleanNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let format: [Character] = Array(pattern)
        let code = String(format)
            .replacingOccurrences(of: "\(replacing)", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
        
        let codeLessFormat = Array(String(format.suffix(format.count - code.count)))
        var result: [Character] = codeLessFormat
        var index = cleanNumber.startIndex
        var resultIndex = result.startIndex
        for ch in codeLessFormat {
            if index == cleanNumber.endIndex {
                break
            }
            if ch == replacing {
                result.insert(cleanNumber[index], at: resultIndex)
                result.remove(at: resultIndex + 1)
                index = cleanNumber.index(after: index)
                resultIndex += 1
            } else {
                result.insert(ch, at: resultIndex)
                result.remove(at: resultIndex + 1)
                resultIndex += 1
            }
        }
        
        
        return code + result
    }
}


enum PhoneNumberCheckStatus {
    case empty
    case short
    case startingIncorrect
    case valid
}
