//
//  View+extension.swift
//  MobileTest
//
//  Created by Maksim Guzeev on 19.12.2023.
//

import Foundation
import SwiftUI


extension View {
    func setBackground(color: Color = .bgMain) -> some View {
        ZStack {
            color.ignoresSafeArea()
            self
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func readHeight(height: Binding<CGFloat>) -> some View {
        modifier(ReadHeight(height: height))
    }
    
    func onFirstAppear(_ onFirstAppearAction: @escaping () -> () ) -> some View {
        return modifier(OnFirstAppearModifier(onFirstAppearAction))
    }
}

struct ReadHeight: ViewModifier {
    @Binding var height: CGFloat

    func body(content: Content) -> some View {
        content.background(
            GeometryReader { geometry in
                Color.clear.preference(
                    key: ReadHeightPreferenceKey.self,
                    value: geometry.size.height
                )
            }
            .onPreferenceChange(ReadHeightPreferenceKey.self) { newHeight in
                height = newHeight.rounded(.up)
            }
        )
    }
}

struct ReadHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


public struct OnFirstAppearModifier: ViewModifier {

    private let onFirstAppearAction: () -> ()
    @State private var hasAppeared = false
    
    public init(_ onFirstAppearAction: @escaping () -> ()) {
        self.onFirstAppearAction = onFirstAppearAction
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                guard !hasAppeared else { return }
                hasAppeared = true
                onFirstAppearAction()
            }
    }
}
