//
//  RoomInfoRequest.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import Foundation


struct RoomInfoRequest: ApiRequestProtocol {
    var parameters: [URLQueryItem]? = nil
    
    typealias Response = RoomsModel
    
    var endpoint: String {
        "/v3/8b532701-709e-4194-a41c-1a903af00195"
    }
    
    
}
