//
//  ContentView.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 19.12.2023.
//

import SwiftUI

struct HotelView: View {
    @StateObject var vm = HotelViewModel()
    @EnvironmentObject var coordinator: Coordinator<HotelRouter>
    @State private var selection = 0
    var body: some View {
        MainTemplate(title: "Отель", showButton: false, action: nil) {
            VStack {
                ScrollView {
                    VStack {
                        mainModule
                        aboutHotel
                        HStack {
                            Spacer()
                            Text("К выбору номера")
                                .foregroundColor(.white)
                                .font(.medium16)
                            Spacer()
                        }
                        .frame(height: 48)
                        .padding()
                        .hidden()
                    }
                }
            }
            .setBackground()
            .overlay(alignment: .bottom) {
                VStack {
                    Divider()
                    Button {
                        if let hotel = vm.hotelModel {
                            coordinator.show(.room(hotel: hotel))
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("К выбору номера")
                                .foregroundColor(.white)
                                .font(.medium16)
                            Spacer()
                        }
                        .frame(height: 48)
                        .background(.blue)
                        .cornerRadius(15)
                        .padding()
                    }
                }
                .background(.white)
            }
            .onFirstAppear {
                vm.getHotelInfo()
            }
        }
    }
    
    private var mainModule: some View {
        VStack {
            imageModule
            mainInfo
                .padding(.horizontal)
        }
        .background(
            Color.white
                .cornerRadius(12)
        )
    }
    
    private var imageModule: some View {
        ImageTabView(images: vm.hotelModel?.imageUrls, selection: $selection)
//        Group {
//            if let images = vm.hotelModel?.imageUrls {
//                TabView(selection: $selection) {
//                    ForEach(images.indices, id: \.self) { index in
//                        let img = images[index]
//                        AsyncImage(url: URL(string: img)!) { result in
//                            switch result {
//                            case .success(let img):
//                                img
//                                    .resizable()
//                                    .frame(height: 260)
//                                    .scaledToFit()
//                                    .cornerRadius(15)
//                            default:
//                                ProgressView()
//                                    .progressViewStyle(CircularProgressViewStyle())
//                            }
//                        }
//                        .tag(index)
//                        .padding(.horizontal)
//                    }
//                    
//                }
//                .tabViewStyle(.page(indexDisplayMode: .never))
//                .frame(height: 260)
//                .overlay {
//                    VStack {
//                        Spacer()
//                        CustomSelection(selection: $selection, count: images.count)
//                            .offset(y: -8)
//                    }
//                    
//                }
//                .padding(.top)
//            } else {
//                RoundedRectangle(cornerRadius: 15)
//                    .foregroundColor(.white)
//                    .frame(height: 260123)
//                    .overlay {
//                        ProgressView()
//                    }
//            }
//        }
        

    }
    
    private var mainInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            RatingView(rating: vm.hotelModel?.rating ?? 0, ratingDescription: vm.hotelModel?.ratingName ?? "")
            Text(vm.hotelModel?.name ?? "")
                .font(.medium22)
                .foregroundColor(.black)
            Text(vm.hotelModel?.adress ?? "")
                .font(.medium14)
                .foregroundColor(Color.textBlue)
                .padding(.bottom, 8)
            
            Text("от \(vm.hotelModel?.minimalPrice ?? 0) ₽")
                .font(.bold30)
                .foregroundColor(.black)
            +
            Text(" ")
            +
            Text(vm.hotelModel?.priceForIt ?? "")
                .font(.regular16)
                .foregroundColor(.textGray)
            HStack {Spacer()}
        }
        
    }
    
    private var aboutHotel: some View {
        VStack(alignment: .leading) {
            Text("Об отеле")
                .font(.medium22)
                .foregroundColor(.black)
            if let chips = vm.hotelModel?.aboutTheHotel.peculiarities {
                FlowLayout(chips, spacing: 3) { chip in
                    Text(chip)
                        .font(.medium16)
                        .foregroundColor(.textGray)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 5)
                        .background(Color.bgChips)
                        .cornerRadius(5)
                }
            }
            Text(vm.hotelModel?.aboutTheHotel.description ?? "")
                .font(.regular16)
                .foregroundColor(.black)
            VStack {
                ForEach(vm.prefferencies) { pref in
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Image(pref.image)
                                .foregroundColor(.black)
                                .offset(y: -5)
                            VStack(alignment: .leading) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(pref.title)
                                            .foregroundColor(.black)
                                            .font(.medium16)
                                        Text(pref.description)
                                            .font(.medium14)
                                            .foregroundColor(.textGray)
                                        
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.black)
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    HotelView()
}
