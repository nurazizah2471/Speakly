//
//  EvaluationWordView.swift
//  Speakly
//
//  Created by Nur Azizah on 23/11/23.
//

import SwiftUI

struct EvaluationWordView: View {
    @Environment(\.navigate) private var navigate
    
    var body: some View {
        VStack {
            HStack {
                Text("Hasil latihan")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
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
                        Text("Latihan Mandiri")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                        Text("Lihat hasil latihan mandiri disini!")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .onTapGesture {
                    navigate.append(.evaluationWordIndependentView)
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
                        Text("Latihan Rekomendasi")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                        Text("Lihat hasil latihan \n rekomendasi terapis disini!")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .onTapGesture {
                    
                }
            }
            Spacer()
        }
        .padding(.leading, 30)
    }
}

#Preview {
    EvaluationWordView()
}
