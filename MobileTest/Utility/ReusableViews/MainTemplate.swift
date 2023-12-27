//
//  MainTemplate.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 25.12.2023.
//

import SwiftUI

struct MainTemplate<Content: View>: View {
    let title: String?
    let showButton: Bool
    let action: (()->())?
    @ViewBuilder var content: Content
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack() {
                Color.white
                    .ignoresSafeArea()
                HStack {
                    if let title = title {
                        Text(title)
                            .lineLimit(1)
                            .font(.medium18)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading, showButton ? 32 : 16)
                            .padding(.trailing, 16)
                    }
                }
                HStack {
                    Button {
                        if let action = action {
                            action()
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.medium18)
                            .foregroundColor(.black)
                    }
                    .disabled(!showButton)
                    .opacity(showButton ? 1 : 0)
                    .padding(.leading)
                    Spacer()
                }
            }
            .frame(height: 44)
            content
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    MainTemplate(title: "some titlekj uhr wiue urhew irh  rwuh reih ur wi", showButton: true, action: {}, content: {
        
        VStack {
            
            Spacer()
            Text("text")
            Spacer()
            HStack{Spacer()}
        }
        .background(Color.red)
        
    })
}
