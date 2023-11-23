//
//  LoadingView.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import SwiftUI

struct LoadingView: View {
    @Binding var informationText: String
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2.0, anchor: .center)
                Text(informationText)
                    .font(.system(size: 12))
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}

#Preview {
    LoadingView(informationText: .constant("Loading..."))
}
