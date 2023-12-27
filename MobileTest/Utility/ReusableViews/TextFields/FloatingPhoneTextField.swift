//
//  FloatingPhoneTextField.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 26.12.2023.
//

import SwiftUI

struct FloatingPhoneTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var color: Color
    @FocusState var focused: Bool
    @State private var maskedText = ""
    var body: some View {
        ZStack(alignment: .leading) {
            Text(placeholder)
                .foregroundColor(.textGray)
                .font(!focused && text.isEmpty ? .regular17 : .regular12)
                .offset(y: !focused && text.isEmpty ? 0 : -17)
            TextField("", text: $text)
                .focused($focused)
                .font(.regular17)
                .opacity(.ulpOfOne)
                .padding(.leading, 30)
                .onChange(of: text) { _ in
                    maskedText = text.formatPhone(pattern: "+7 (***) *** **-**", replacing: "*")
                }
                .overlay(alignment: .leading) {
                    
                    if (text.isEmpty && focused) || !text.isEmpty && !focused || (!text.isEmpty && focused) {
                        Text(maskedText)
                            //.offset(x: 16)
                            .foregroundColor(.black)
                    }
                }
                .onChange(of: focused) { newVal in
                    
                    
                    if newVal && text.isEmpty{
                        maskedText = text.formatPhone(pattern: "+7 (***) *** **-**", replacing: "*")
                    }
                    

                    
                }
        }
        .padding()
        .frame(height: 52)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(color)
        )
        .onTapGesture {
            focused = true
        }
    }
}

#Preview {
    BookingView()
}
