//
//  ImageTabView.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 27.12.2023.
//

import Foundation
import SwiftUI


struct ImageTabView: View {
    
    let images: [String]?
    @Binding var selection: Int
    
    var body: some View {
        Group {
            if let images = images {
                TabView(selection: $selection) {
                    ForEach(images.indices, id: \.self) { index in
                        let img = images[index]
                        AsyncImage(url: URL(string: img)!) { result in
                            switch result {
                            case .success(let img):
                                img
                                    .resizable()
                                    .frame(height: 260)
                                    .scaledToFit()
                                    .cornerRadius(15)
                            default:
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            }
                        }
                        .tag(index)
                        .padding(.horizontal)
                    }
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 260)
                .overlay {
                    VStack {
                        Spacer()
                        CustomSelection(selection: $selection, count: images.count)
                            .offset(y: -8)
                    }
                    
                }
                .padding(.top)
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .frame(height: 260123)
                    .overlay {
                        ProgressView()
                    }
            }
        }
    }
}
