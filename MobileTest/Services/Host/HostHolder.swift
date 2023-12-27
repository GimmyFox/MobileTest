//
//  HostHolder.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 19.12.2023.
//

import Foundation


protocol HostHolderService {
    var host: String { get }
}

final class HostHolder: HostHolderService {
    static let shared = HostHolder()
    
    private init() {}
    
    var host: String {
        "run.mocky.io"
    }
}
