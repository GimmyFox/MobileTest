//
//  HotelRouter.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 25.12.2023.
//

import Foundation
import SwiftUI

enum HotelRouter: NavigationRouter {
    
    case hotel
    case room(hotel: HotelModel)
    case booking
    case payment
    
    public var transition: NavigationTranisitionStyle {
        switch self {
        case .hotel:
            return .push
        case .room:
            return .push
        case .booking:
            return .push
        case .payment:
            return .push
        }
    }
    
    public func view() -> some View {
        switch self {
        case .hotel:
            HotelView()
        case .room(let hotel):
            RoomView(hotel: hotel)
        case .booking:
            BookingView()
        case .payment:
            PaymanetView()
        }
    }
}
