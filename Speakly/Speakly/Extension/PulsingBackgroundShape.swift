//
//  PulsingBackgroundShape.swift
//  Speakly
//
//  Created by Daniel Aprillio on 18/11/23.
//

import Foundation
import SwiftUI

extension View {
    func pulsingBackgroundShape<S: Shape>(
        color: Color,
        shape: S,
        isPulsing: Binding<Bool>,
        maxXScale: CGFloat = 1.2,
        maxYScale: CGFloat = 1.2,
        animationDuration: Double = 1.5
    ) -> some View {
        return self.background(
            shape
                .fill(color)
                .scaleEffect(x: isPulsing.wrappedValue ? maxXScale : 1.0, y: isPulsing.wrappedValue ? maxYScale : 1.0)
                .opacity(isPulsing.wrappedValue ? 0 : 1)
                .onAppear {
                    withAnimation(
                        Animation.easeInOut(duration: animationDuration)
                            .repeatForever(autoreverses: false)
                    ) {
                        isPulsing.wrappedValue.toggle()
                    }
                }
        )
    }
}
