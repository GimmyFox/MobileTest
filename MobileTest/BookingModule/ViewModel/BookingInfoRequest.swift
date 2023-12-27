//
//  BookingInfoRequest.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import Foundation


struct BookingInfoRequest: ApiRequestProtocol {
    var parameters: [URLQueryItem]? = nil
    
    typealias Response = BookingModel
    
    var endpoint: String {
        "/v3/63866c74-d593-432c-af8e-f279d1a8d2ff"
    }
}
