//
//  RatingView.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import SwiftUI

struct RatingView: View {
    let rating: Int
    let ratingDescription: String
    var body: some View {
        HStack(spacing: 2) {
            Image("starRating")
            Text("\(rating) " + "\(ratingDescription)")
                .font(.medium16)
                .foregroundColor(.fgRating)
        }
        .padding(5)
        .background(Color.bgRating)
        .cornerRadius(5)
    }
}

#Preview {
    RatingView(rating: 5, ratingDescription: "Unbelivable")
}
