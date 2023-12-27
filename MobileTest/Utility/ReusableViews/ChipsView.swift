//
//  ChipsView.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 19.12.2023.
//

import SwiftUI


struct FlowLayout<Data, RowContent>: View where Data: RandomAccessCollection, RowContent: View, Data.Element: Hashable {
    
    
  @State private var height: CGFloat = .zero

  private var data: Data
  private var spacing: CGFloat
  private var rowContent: (Data.Element) -> RowContent

  public init(_ data: Data, spacing: CGFloat = 4, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) {
    self.data = data
    self.spacing = spacing
    self.rowContent = rowContent
  }

    var body: some View {
        GeometryReader { geometry in
            content(in: geometry)
                .readHeight(height: $height)
          }
          .frame(height: height)
    }
    
    private func content(in geometry: GeometryProxy) -> some View {
        var bounds = CGSize.zero
        return ZStack {
            ForEach(data, id: \.hashValue) { item in
                rowContent(item)
                    .padding([.top, .trailing, .bottom], spacing)
                    .alignmentGuide(VerticalAlignment.center) { dimension in
                        let result = bounds.height
                        
                        if let lastItem = data.last, item == lastItem {
                            bounds.height = 0
                        }
                        return result
                    }
                    .alignmentGuide(HorizontalAlignment.center) { dimension in
                        if abs(bounds.width - dimension.width) > geometry.size.width {
                            bounds.width = 0
                            bounds.height -= dimension.height
                        }
                        
                        let result = bounds.width
                        
                        if let lastItem = data.last, item == lastItem {
                            bounds.width = 0
                        } else {
                            bounds.width -= dimension.width
                        }
                        return result
                    }
            }
        }
    }
}
