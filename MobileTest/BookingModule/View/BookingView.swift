//
//  BookingView.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import SwiftUI
import Combine

struct BookingView: View {
    @StateObject var vm = BookingViewModel()
    @EnvironmentObject var coodrinator: Coordinator<HotelRouter>
    @State var tapped: Bool = false
    @FocusState private var phoneNumberFocused: Bool
    var body: some View {
        MainTemplate(title: "Бронирование", showButton: true) {
            coodrinator.pop()
        } content: {
            VStack {
                ScrollView {
                    VStack {
                        hotelInfo
                        bookingInfo
                        buyerInfo
                        touristInfo
                        addTourist
                        overallCostInfo
                            .padding(.bottom, 5)
                        HStack {
                            Spacer()
                            Text("Оплатить \(vm.totalCost)")
                                .foregroundColor(.white)
                                .font(.medium16)
                            Spacer()
                        }
                        .frame(height: 48)
                        .background(.blue)
                        .cornerRadius(15)
                        .padding()
                        .hidden()
                    }
                    .padding(.vertical, 8)
                }
            }
            .setBackground()
            .overlay(alignment: .bottom) {
                VStack {
                    Divider()
                    
                    Button {
                        tapped.toggle()
                        if vm.checkData() {
                            coodrinator.show(.payment)
                        } else {
                            //
                        }
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Оплатить \(vm.totalCost) ₽")
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
                vm.getBookingInfo()
            }
        }
    }
    
    private var hotelInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let booking = vm.booking {
                RatingView(rating: booking.horating, ratingDescription: booking.ratingName)
                Text(booking.hotelName)
                    .font(.medium22)
                    .foregroundColor(.black)
                Text(booking.hotelAdress)
                    .font(.medium14)
                    .foregroundStyle(.textBlue)
            }
            HStack{Spacer()}
        }
        .padding()
        .background(Color.white)
        .cornerRadius(22)
    }
    
    private var bookingInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let booking = vm.booking {
                HStack(alignment: .top) {
                    Text("Вылет из")
                        .frame(width: (UIScreen.main.bounds.width - 32) * 0.43 , alignment: .leading)
                        .foregroundColor(.textGray)
                    Text(booking.departure)
                        .foregroundColor(.black)
                }
                .font(.regular16)
                HStack(alignment: .top) {
                    Text("Страна, город")
                        .frame(width: (UIScreen.main.bounds.width - 32) * 0.43 , alignment: .leading)
                        .foregroundColor(.textGray)
                    Text(booking.arrivalCountry)
                        .foregroundColor(.black)
                }
                .font(.regular16)
                HStack(alignment: .top) {
                    Text("Даты")
                        .frame(width: (UIScreen.main.bounds.width - 32) * 0.43 , alignment: .leading)
                        .foregroundColor(.textGray)
                    Text("\(booking.tourDateStart) - \(booking.tourDateStop)")
                        .foregroundColor(.black)
                }
                .font(.regular16)
                HStack(alignment: .top) {
                    Text("Кол-во ночей")
                        .frame(width: (UIScreen.main.bounds.width - 32) * 0.43 , alignment: .leading)
                        .foregroundColor(.textGray)
                    Text("\(booking.numberOfNights)")
                        .foregroundColor(.black)
                }
                .font(.regular16)
                HStack(alignment: .top) {
                    Text("Отель")
                        .frame(width: (UIScreen.main.bounds.width - 32) * 0.43 , alignment: .leading)
                        .foregroundColor(.textGray)
                    Text(booking.hotelName)
                        .foregroundColor(.black)
                }
                .font(.regular16)
                
                HStack(alignment: .top) {
                    Text("Номер")
                        .frame(width: (UIScreen.main.bounds.width - 32) * 0.43 , alignment: .leading)
                        .foregroundColor(.textGray)
                    Text(booking.room)
                        .foregroundColor(.black)
                }
                .font(.regular16)
                HStack(alignment: .top) {
                    Text("Питание")
                        .frame(width: (UIScreen.main.bounds.width - 32) * 0.43 , alignment: .leading)
                        .foregroundColor(.textGray)
                    Text(booking.nutrition)
                        .foregroundColor(.black)
                }
                .font(.regular16)
            }
            HStack{Spacer()}
        }
        .padding()
        .background(Color.white)
        .cornerRadius(22)
    }
    
    private var buyerInfo: some View {
        VStack(alignment: .leading) {
            Text("Информация о покупателе")
                .font(.medium22)
                .foregroundColor(.black)
                .padding(.bottom, 20)
            
            FloatingPhoneTextField(placeholder: "Номер телефона", text: $vm.phoneNumber, color: vm.isValidPhone ? .bgMain : .error, focused: _phoneNumberFocused)
                .keyboardType(.numberPad)
                .onReceive(Just(vm.phoneNumber), perform: { _ in
                    limitText(10)
                })

            FloatingTextField(placeholder: "Почта", text: $vm.emailTxt, color: vm.isValidEmail ? .bgMain : .error)
                .keyboardType(.emailAddress)
                
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
    
    private var touristInfo: some View {
        VStack {
            
            ForEach($vm.tourists.indices, id: \.self) { index in
                let tourist = $vm.tourists[index]
                TouristView(tourist: tourist, buttonTapped: $tapped, touristCount: vm.getTouristCount(index: index))
            }
        }
    }
    
    private var addTourist: some View {
        HStack {
            Text("Добавить туриста")
                .font(.medium22)
                .foregroundColor(.black)
            Spacer()
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 32, height: 32)
                .foregroundColor(.textBlue.opacity(0.1))
                .overlay {
                    Image(systemName: "plus")
                        
                        .foregroundColor(.textBlue)
                }
                .onTapGesture {
                    withAnimation {
                        vm.addNewTourist()
                    }
                }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
    
    private var overallCostInfo: some View {
        Group {
            if let booking = vm.booking {
                VStack(spacing: 16) {
                    HStack {
                        Text("Тур")
                            .font(.regular16)
                            .foregroundColor(.textGray)
                        Spacer()
                        Text("\(booking.tourPrice) ₽")
                            .font(.regular16)
                            .foregroundColor(.black)
                    }
                    
                    HStack {
                        Text("Топливный сбор")
                            .font(.regular16)
                            .foregroundColor(.textGray)
                        Spacer()
                        Text("\(booking.fuelCharge) ₽")
                            .font(.regular16)
                            .foregroundColor(.black)
                    }
                    HStack {
                        Text("Сервисный сбор")
                            .font(.regular16)
                            .foregroundColor(.textGray)
                        Spacer()
                        Text("\(booking.serviceCharge) ₽")
                            .font(.regular16)
                            .foregroundColor(.black)
                    }
                    
                    HStack {
                        Text("К оплате")
                            .font(.regular16)
                            .foregroundColor(.textGray)
                        Spacer()
                        Text("\(vm.totalCost) ₽")
                            .font(.bold16)
                            .foregroundColor(.textBlue)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
            }
            
        }
    }
    
    
    private func limitText(_ upper: Int) {
        if vm.phoneNumber.count > upper {
            vm.phoneNumber = String(vm.phoneNumber.prefix(upper))
        }
    }
}

#Preview {
    BookingView()
}
