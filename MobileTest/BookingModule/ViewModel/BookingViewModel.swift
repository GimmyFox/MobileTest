//
//  BookingViewModel.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import Foundation
import Combine
import SwiftUI

final class BookingViewModel: ObservableObject {
    
    @Published var booking: BookingModel?
    @Published var tourists: [Tourist.TouristView] = [.first]
    @Published private(set) var totalCost = 0
    
    @Published var phoneNumber = ""
    @Published var emailTxt = ""
    @Published var isValidEmail = true
    @Published var isValidPhone = true
    
    let network: BookingRequestServiceProtocol
    init() {
        self.network = BookingRequestService(client: DefaultNetworkService())
    }
    
    
    func addNewTourist() {
        let model = Tourist.TouristModel.firstTourist
        let fields = ValidModel.initialValue
        let tourist = Tourist.TouristView(touristModel: model, validFields: fields)
        tourists.append(tourist)
    }
    
    
    func checkData() -> Bool{

        let valid = tourists.allSatisfy { model in
            !model.touristModel.name.isEmpty &&
            !model.touristModel.surname.isEmpty &&
            !model.touristModel.birthDate.isEmpty &&
            !model.touristModel.citizenship.isEmpty &&
            !model.touristModel.pasportNo.isEmpty &&
            !model.touristModel.passportEnding.isEmpty
        }

        if valid && emailTxt.isValidEmail() && phoneNumber
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "").count == 10
        {
            return true
            
        }
        
        isValidEmail = emailTxt.isValidEmail()
        isValidPhone = (phoneNumber
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .count == 10)
        
        return false
    }
    
    func getBookingInfo() {
        let request = BookingInfoRequest()
        network.requestBooking(request: request) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    withAnimation {
                        self?.booking = model
                        self?.totalCost = model.fuelCharge + model.serviceCharge + model.tourPrice
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getTouristCount(index: Int) -> String {
        switch index {
        case 0:
            return "Первый турист"
        case 1:
            return "Второй турист"
        case 2:
            return "Третий турист"
        case 3:
            return "Четвертый турист"
        case 4:
            return "Пятый турист"
        default:
            return "Новый турист"
        }
    }
}
