//
//  FloatingTextField.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 21.12.2023.
//

import SwiftUI

struct FloatingTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var color: Color
    var body: some View {
        ZStack(alignment: .leading) {
            Text(placeholder)
                .foregroundStyle(.textGray)
                .font(text.isEmpty ? .regular17 : .regular12)
                .offset(y: text.isEmpty ? 0 : -17)
            TextField("", text: $text)
                .font(.regular17)
                .foregroundColor(.black)
        }
        .animation(.default, value: text)
        .padding()
        .frame(height: 52)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(color)
        )
        .onChange(of: text) { _ in
            print(text)
        }
    }
}

#Preview {
    FloatingTextField(placeholder: "", text: .constant(""), color: .bgMain)
}
