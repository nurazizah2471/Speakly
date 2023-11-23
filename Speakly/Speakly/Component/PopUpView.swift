//
//  PopUpView.swift
//  Speakly
//
//  Created by Nur Azizah on 23/11/23.
//

import SwiftUI

struct PopUpView: View {
    @Environment(\.navigate) private var navigate
    @Environment(\.wordPracticeViewModel) private var wordPracticeViewModel
    
    var correctWord: String = ""
    var answerWord: String = ""
    
    @Binding var isShowingPopup: Bool
    @Binding var isRandomSpeechPrompt: Bool
    @Binding var counterWord: Int
    @Binding var isTryAgain: Bool
    @Binding var getSpeechPrompt: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    VStack(spacing: 10) {
                        Text("Hasil")
                            .bold()
                            .font(.system(size: 20))
                        
                        Text(correctWord == answerWord ? "Pengucapan benar!" : "Pengucapan masih belum benar!")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                            .bold()
                    }
                    
                    VStack {
                        HStack(spacing: 10) {
                            ForEach(0..<correctWord.count, id: \.self) { index in
                                let correctLetter = correctWord[correctWord.index(correctWord.startIndex, offsetBy: index)]
                                
                                if index < answerWord.count {
                                    if answerWord.indices.contains(answerWord.index(answerWord.startIndex, offsetBy: index)) {
                                        
                                        let textColor: Color = correctLetter == answerWord[answerWord.index(answerWord.startIndex, offsetBy: index)] ? .green : .red
                                        
                                        Text(String(correctLetter))
                                            .foregroundColor(textColor)
                                    } else {
                                        let textColor: Color = correctLetter == " " ? .green : .red
                                        
                                        Text(String(correctLetter))
                                            .foregroundColor(textColor)
                                    }
                                } else {
                                    Text(String(correctLetter))
                                        .foregroundColor(.red)
                                }
                                
                                
                            }
                        }
                    }
                    .padding(.top, 15)
                    
                    HStack(spacing: 10) {
                        if isTryAgain {
                            Button(action: {
                                isShowingPopup.toggle()
                                isTryAgain.toggle()
                                wordPracticeViewModel.getSpeechPrompt = nil
                            }, label: {
                                    Text("Tutup")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.init(hex: "9D0303"))
                                        .cornerRadius(38)
                            })
                            .padding(10)
                            .padding(.top, 5)
                        }
                                   
                        Button(action: {
                            isShowingPopup.toggle()
                            
                            if !isTryAgain {
                                wordPracticeViewModel.getSpeechPrompt = nil
                                navigate.pop()
                            } else {
                                isTryAgain.toggle()
                                wordPracticeViewModel.getSpeechPrompt = getSpeechPrompt
                                
                                navigate.append(.practiceWordIndependent)
                            }
                            
                        }, label: {
                                Text(isTryAgain ? "Coba Ulang" : "Akhiri latihan")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(isTryAgain ? Color.init(hex: "59B3E9") : Color.init(hex: "9D0303"))
                                    .cornerRadius(38)
                        })
                        .padding(10)
                        .padding(.top, 5)
                        
                        if !isTryAgain {
                            Button(action: {
                                isShowingPopup.toggle()
                                isRandomSpeechPrompt.toggle()
                                counterWord = counterWord+1
                            }, label: {
                                Text("Lanjutkan")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.init(hex: "59B3E9"))
                                    .cornerRadius(38)
                            })
                            .padding(10)
                            .padding(.top, 5)
                        }
                    }
                    .padding(.top, 15)
                }
            }
            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.4)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    PopUpView(isShowingPopup: .constant(true), isRandomSpeechPrompt: .constant(false), counterWord: .constant(0), isTryAgain: .constant(false), getSpeechPrompt: .constant(""))
}
