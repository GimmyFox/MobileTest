//
//  RoomRequestService.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import Foundation



protocol RoomRequestServiceProtocol {
    func requestRooms(request: RoomInfoRequest, completion: @escaping (Result<RoomsModel, ApiClientError>) -> Void)
}

final class RoomRequestService: RoomRequestServiceProtocol {
    
    let client: NetworkServiceProtocol
    init(client: NetworkServiceProtocol) {
        self.client = client
    }
    
    
    func requestRooms(request: RoomInfoRequest, completion: @escaping (Result<RoomsModel, ApiClientError>) -> Void) {
        client.request(request: request) { result in
            completion(result)
        }
    }
}
