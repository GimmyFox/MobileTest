//
//  MobileTestApp.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 19.12.2023.
//

import SwiftUI

@main
struct MobileTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    init() {
        
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HotelView()
            }
            .tint(.black)
        }
    }
}



