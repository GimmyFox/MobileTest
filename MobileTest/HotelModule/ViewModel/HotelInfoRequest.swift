//
//  HotelInfoRequest.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 19.12.2023.
//

import Foundation


struct HotelInfoRequest: ApiRequestProtocol {
    var parameters: [URLQueryItem]? = nil
    
    typealias Response = HotelModel
    
    var endpoint: String {
        "/v3/d144777c-a67f-4e35-867a-cacc3b827473"
    }
    
    
}
