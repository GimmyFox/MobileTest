//
//  CustomSelection.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 20.12.2023.
//

import SwiftUI

struct CustomSelection: View {
    @Binding var selection: Int
    @State var count: Int
    var body: some View {
        HStack {
            ForEach(0...count - 1, id: \.self) { circle in
                Circle()
                    .frame(width: 7, height: 7)
                    .foregroundColor(selection == circle ? .black : .unselectedPaging)
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(Color.white)
        .cornerRadius(5)
    }
}

#Preview {
    CustomSelection(selection: .constant(0), count: 3)
}
