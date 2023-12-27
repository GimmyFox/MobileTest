//
//  HotelRequestService.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 19.12.2023.
//

import Foundation


protocol HotelRequestServiceProtocol {
    func requestHotel(request: HotelInfoRequest, completion: @escaping (Result<HotelModel, ApiClientError>) -> Void)
}

final class HotelRequestService: HotelRequestServiceProtocol {
    
    let client: NetworkServiceProtocol
    init(client: NetworkServiceProtocol) {
        self.client = client
    }
    
    
    func requestHotel(request: HotelInfoRequest, completion: @escaping (Result<HotelModel, ApiClientError>) -> Void) {
        client.request(request: request) { result in
            completion(result)
        }
    }
}
