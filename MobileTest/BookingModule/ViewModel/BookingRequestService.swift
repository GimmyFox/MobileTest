//
//  BookingRequestService.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import Foundation

protocol BookingRequestServiceProtocol {
    func requestBooking(request: BookingInfoRequest, completion: @escaping (Result<BookingModel, ApiClientError>) -> Void)
}

final class BookingRequestService: BookingRequestServiceProtocol {
    
    let client: NetworkServiceProtocol
    init(client: NetworkServiceProtocol) {
        self.client = client
    }
    
    
    func requestBooking(request: BookingInfoRequest, completion: @escaping (Result<BookingModel, ApiClientError>) -> Void) {
        client.request(request: request) { result in
            completion(result)
        }
    }
}
