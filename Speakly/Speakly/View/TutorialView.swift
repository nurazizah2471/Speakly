//
//  TutorialView.swift
//  Speakly
//
//  Created by Nur Azizah on 23/11/23.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Kamu belum menyewa terapis. Sewa terapis untuk mendapatkan video tutorial")
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .padding(.top, 50)
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    TutorialView()
}
