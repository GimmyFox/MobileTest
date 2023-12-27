//
//  RoomModel.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import Foundation

struct RoomsModel: Codable {
    let rooms: [Room]
}

// MARK: - Room
struct Room: Codable {
    let id: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case pricePer = "price_per"
        case peculiarities
        case imageUrls = "image_urls"
    }
    
    static let test1 = Room(id: 1, name: "my room", price: 10000, pricePer: "for it", peculiarities: ["wow", "amazing"], imageUrls: [])
}
