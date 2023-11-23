//
//  PracticeView.swift
//  Speakly
//
//  Created by Nur Azizah on 23/11/23.
//

import SwiftUI

struct PracticeView: View {
    @Environment(\.navigate) private var navigate
    
    var body: some View {
        VStack {
            HStack {
                Text("Mulai Latihan")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.top, 30)
            
            ScrollView {
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .frame(width: Screen.width * 0.8, height: Screen.height * 0.2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    
                    VStack(spacing: 10) {
                        Text("Ingin uji kejelasan berbicara?")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                        Text("Latihan secara mandiri yuk!")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .onTapGesture {
                    navigate.append(.practiceWordIndependent)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .frame(width: Screen.width * 0.8, height: Screen.height * 0.2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    
                    VStack(spacing: 10) {
                        Text("Sudah bertemu terapis?")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                        Text("Lihat rekomendasi \n latihan dari terapis yuk!")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .frame(width: Screen.width * 0.8, height: Screen.height * 0.2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                    
                    VStack(spacing: 10) {
                        Text("Lihat hasil latihan?")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                        Text("Evaluasi dan lakukan perbaikan!")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .onTapGesture {
                    navigate.append(.evaluationWord)
                }
            }
            Spacer()
        }
        .padding(.leading, 30)
    }
}

#Preview {
    PracticeView()
}
