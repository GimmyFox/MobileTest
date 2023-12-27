//
//  HotelModel.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 19.12.2023.
//

import Foundation


struct HotelModel: Decodable {
    let id: Int
    let name, adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    var aboutTheHotel: AboutTheHotel

    enum CodingKeys: String, CodingKey {
        case id, name, adress
        case minimalPrice = "minimal_price"
        case priceForIt = "price_for_it"
        case rating
        case ratingName = "rating_name"
        case imageUrls = "image_urls"
        case aboutTheHotel = "about_the_hotel"
    }
    
    static let test1 = HotelModel(id: 1, name: "HotelName", adress: "Hotel address", minimalPrice: 1000, priceForIt: "for it", rating: 5, ratingName: "Spectacular", imageUrls: [], aboutTheHotel: .init(description: "description", peculiarities: ["wow", "amazing"]))
}

// MARK: - AboutTheHotel
struct AboutTheHotel: Decodable {
    let description: String
    var peculiarities: [String]
}

struct PreferencesModel: Identifiable {
    var id = UUID()
    let title: String
    let image: String
    let description: String
    
    static let prefference1 = PreferencesModel(title: "Удобства", image: "happyEmoji", description: "Самое необходимое")
    static let prefference2 = PreferencesModel(title: "Что включено", image: "tickSquare", description: "Самое необходимое")
    static let prefference3 = PreferencesModel(title: "Что не включено", image: "closeSquare", description: "Самое необхожимое")
}
