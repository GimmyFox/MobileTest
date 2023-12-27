//
//  TouristView.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import SwiftUI

struct TouristView: View {
    
    
    @Binding var tourist: Tourist.TouristView
    
    @State private var isOpened = false
    @Binding var buttonTapped: Bool
    let touristCount: String
    var body: some View {
            VStack {
                HStack {
                    Text(touristCount)
                        .foregroundColor(.black)
                        .font(.medium22)
                    Spacer()
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 32, height: 32)
                        .foregroundColor(.textBlue.opacity(0.1))
                        .overlay {
                            Image(systemName: isOpened ? "chevron.left" : "chevron.right")
                                .rotationEffect(.degrees(90))
                                .foregroundColor(.textBlue)
                        }
                        .onTapGesture {
                            withAnimation {
                                isOpened.toggle()
                            }
                        }
                }
                if isOpened {
                    FloatingTextField(placeholder: "Имя", text: $tourist.touristModel.name, color: tourist.validFields.validName ? .bgMain : .error)
                        
                    FloatingTextField(placeholder: "Фамилия", text: $tourist.touristModel.surname, color: tourist.validFields.validSurname ? .bgMain : .error)
                        
                    FloatingTextField(placeholder: "Дата рождения", text: $tourist.touristModel.birthDate, color: tourist.validFields.validBirthday ? .bgMain : .error)
                        
                    FloatingTextField(placeholder: "Гражданство", text: $tourist.touristModel.citizenship, color: tourist.validFields.validCitizenship ? .bgMain : .error)
                        
                    FloatingTextField(placeholder: "Номер загранпаспорта", text: $tourist.touristModel.pasportNo, color: tourist.validFields.validPassNo ? .bgMain : .error)
                        
                    FloatingTextField(placeholder: "Срок действия загранпаспорта", text: $tourist.touristModel.passportEnding, color: tourist.validFields.validPassDateIssue ? .bgMain : .error)
                        
                        
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .onChange(of: buttonTapped) { _ in
                checkTFs()
            }
    }
    
    private func checkTFs() {
        tourist.validFields.validName = !tourist.touristModel.name.isEmpty
        tourist.validFields.validSurname = !tourist.touristModel.surname.isEmpty
        tourist.validFields.validBirthday = !tourist.touristModel.birthDate.isEmpty
        tourist.validFields.validCitizenship = !tourist.touristModel.citizenship.isEmpty
        tourist.validFields.validPassNo = !tourist.touristModel.pasportNo.isEmpty
        tourist.validFields.validPassDateIssue = !tourist.touristModel.passportEnding.isEmpty
        
        withAnimation {
            isOpened = !tourist.validFields.isAnyFalse()
        }
    }
}

#Preview {
    BookingView()
}
