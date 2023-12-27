//
//  RoomViewModel.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import Foundation
import SwiftUI


final class RoomViewModel: ObservableObject {
    @Published var room: RoomsModel?
    let hotel: HotelModel
    
    
    
    private let networkService: RoomRequestServiceProtocol
    init(hotel: HotelModel) {
        self.hotel = hotel
        self.networkService = RoomRequestService(client: DefaultNetworkService())
    }
    
    
    
    func getRooms() {    
        let request = RoomInfoRequest()
        networkService.requestRooms(request: request) { [weak self] result in
            guard let self else {return}
            
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    withAnimation {
                        self.room = model
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
