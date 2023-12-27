//
//  PaymanetView.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 24.12.2023.
//

import SwiftUI

struct PaymanetView: View {
    @EnvironmentObject var coodrinator: Coordinator<HotelRouter>
    let randomOrderID = Int.random(in: 0...100000)
    var body: some View {
        
        MainTemplate(title: "Заказ оплачен", showButton: true) {
            coodrinator.pop()
        } content: {
            VStack(alignment: .center) {
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: 94, height: 94)
                        .foregroundColor(.bgMain.opacity(0.2))
                        .overlay {
                            Image(.partyPopper)
                                .resizable()
                                .frame(width: 44, height: 44)
                                .offset(x: 3)
                        }
                    Spacer()
                        .frame(height: 32)
                    Text("Ваш заказ принят в работу")
                        .font(.medium22)
                        .foregroundColor(.black)
                    Spacer()
                        .frame(height: 20)
                    Text("Подтверждение заказа №\(randomOrderID.fromIntToPureString()) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
                        .multilineTextAlignment(.center)
                        .font(.regular16)
                        .foregroundColor(.textGray)
                    Spacer()
                }
                .padding(.horizontal, 23)
                
                VStack {
                    Divider()
                    Button {
                        coodrinator.popToRoot(animated: true)
                    } label: {
                        HStack {
                            Spacer()
                            Text("Супер!")
                                .foregroundColor(.white)
                                .font(.medium16)
                            Spacer()
                        }
                        .frame(height: 48)
                        .background(.blue)
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color.white)
        }
    }
}

#Preview {
    PaymanetView()
}


