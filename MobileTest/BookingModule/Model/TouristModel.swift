//
//  TouristModel.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 27.12.2023.
//

import Foundation


enum Tourist {
    
    struct TouristView: Identifiable {
        var id = UUID().uuidString
        var touristModel: TouristModel
        var validFields: ValidModel
        
        static let first = TouristView(touristModel: .firstTourist, validFields: .initialValue)
    }
    
    struct TouristModel: Identifiable {
        var id = UUID().uuidString
        var name: String
        var surname: String
        var birthDate: String
        var citizenship: String
        var pasportNo: String
        var passportEnding: String
        
        static let firstTourist: TouristModel = .init(name: "", surname: "", birthDate: "", citizenship: "", pasportNo: "", passportEnding: "")
    }
    
}

struct ValidModel {
    var validName: Bool
    var validSurname: Bool
    var validBirthday: Bool
    var validCitizenship: Bool
    var validPassNo: Bool
    var validPassDateIssue: Bool
    
    
    func isAnyFalse() -> Bool {
         self.validName && self.validSurname && self.validBirthday && self.validCitizenship && self.validPassNo && self.validPassDateIssue
    }
    
    
    static let initialValue = ValidModel(validName: true, validSurname: true, validBirthday: true, validCitizenship: true, validPassNo: true, validPassDateIssue: true)
}
