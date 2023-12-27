//
//  HotelViewModel.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 19.12.2023.
//

import Foundation
import SwiftUI

final class HotelViewModel: ObservableObject {
    
    @Published var hotelModel: HotelModel?
    @Published private(set) var prefferencies: [PreferencesModel] = [.prefference1, .prefference2, .prefference3]
    let networkSerivice: HotelRequestServiceProtocol
    init() {
        self.networkSerivice = HotelRequestService(client: DefaultNetworkService())
    }
    func getHotelInfo() {
        let request = HotelInfoRequest()
        networkSerivice.requestHotel(request: request) { [weak self] result in
            guard let self else {return}
            
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.hotelModel = model
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
