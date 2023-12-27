//
//  RoomCell.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 27.12.2023.
//

import Foundation
import SwiftUI

struct RoomCell: View {
    @ObservedObject var vm: RoomViewModel
    @ObservedObject var coordinator: Coordinator<HotelRouter>
    @State var model: Room
    @State var selection = 0
    var body: some View {
        VStack {
            imageModule
            mainInfo
                .padding()
        }
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private var imageModule: some View {
        ImageTabView(images: model.imageUrls, selection: $selection)
            
    }
    
    private var mainInfo: some View {
        VStack(alignment: .leading) {
            Text(model.name)
                .font(.medium22)
                .foregroundColor(.black)
                FlowLayout(model.peculiarities) { pecul in
                    Text(pecul)
                        .font(.medium16)
                        .foregroundColor(.textGray)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 5)
                        .background(Color.bgChips)
                        .cornerRadius(5)
                }
            HStack {
                Text("Подробнее о номере")
                    .font(.medium16)
                    .foregroundColor(.textBlue)
                    .padding(.leading, 2)
                Image(systemName: "chevron.right")
                    .font(.medium16)
                    .foregroundColor(.textBlue)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(5)
            
            priceInfo
            
            Button {
                coordinator.show(.booking)
            } label: {
                HStack {
                    Spacer()
                    Text("Выбрать номер")
                        .foregroundColor(.white)
                        .font(.medium16)
                    Spacer()
                }
                .frame(height: 48)
                .background(.blue)
                .cornerRadius(15)
            }
        }
    }
    
    private var priceInfo: some View {
        Text("от \(model.price) ₽")
            .font(.bold30)
            .foregroundColor(.black)
        +
        Text(" ")
        +
        Text(model.pricePer)
            .font(.regular16)
            .foregroundColor(.textGray)
    }
}
