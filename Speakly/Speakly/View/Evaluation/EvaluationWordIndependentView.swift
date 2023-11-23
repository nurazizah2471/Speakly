//
//  EvaluationWordIndependentView.swift
//  Speakly
//
//  Created by Nur Azizah on 23/11/23.
//

import SwiftUI

struct EvaluationWordIndependentView: View {
    @Environment(\.wordPracticeViewModel) private var wordPracticeViewModel
    @Environment(\.navigate) private var navigate
    @Environment(\.userViewModel) private var userViewModel
    
    @State var wordArrays: [[String: Int]] = []
    @State var totalSumWordArrays: Int = 0
    @State var sumWordFalse = []
    @State var isShowingPopup: Bool = false
    @State var counterWord: Int = 0
    @State var isRandomSpeechPrompt: Bool = false
    @State var correctWord: String = ""
    @State var answerWord: String = ""
    @State var isTryAgain: Bool = false
    @State var getSpeechPrompt: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Hasil latihan mandiri")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(.leading, 30)
                
                
                VStack(spacing: 25) {
                    HStack {
                        Text("Grafik kesalahan tertinggi")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                    }
                    .padding(.leading, 30)
                    
                    VStack(spacing: 10) {
                        let sortedWords = wordArrays.sorted { $0.values.first! > $1.values.first! }
                        
                        ForEach(0..<min(sortedWords.count, 10), id: \.self) { index in
                            if let word = sortedWords[index].keys.first,
                               let sum = sortedWords[index].values.first {
                                HStack(spacing: 5) {
                                    Text(word)
                                        .foregroundStyle(Color.init(hex: "59B3E9"))
                                        .font(.system(size: 13))
                                        .bold()
                                    
                                    HStack {
                                        ProgressView(value: Double(sum)/Double(totalSumWordArrays)*100, total: 100)
                                            .progressViewStyle(.linear)
                                            .tint(Color.init(hex: "D3EFFF"))
                                            .background(
                                                GeometryReader { geometry in
                                                    Rectangle()
                                                        .foregroundColor(.white)
                                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                                        .scaleEffect(x: CGFloat(CGFloat(sum)/CGFloat(totalSumWordArrays))*100, y: 1.0, anchor: .leading)
                                                }
                                            )
                                            .cornerRadius(6)
                                        
                                        Text("\(String(format: "%.0f", Double(sum)/Double(totalSumWordArrays)*100))%")
                                            .font(.system(size: 13))
                                        
                                    }
                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
                                }
                            }
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 30)

                }
                .padding(.top, 20)
                
                VStack(spacing: 25) {
                    HStack {
                        Text("Persentase kebenaran")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                    }
                    .padding(.leading, 30)
                    
                    
                    ScrollView {
                        VStack {
                            ForEach(wordPracticeViewModel.wordPractices, id: \.self
                            ) { practice in
                                VStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 0)
                                            .fill(Color.white)
                                            .frame(width: 380, height: 100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 100)
                                                    .stroke(Color.gray, lineWidth: 2)
                                            )
                                        
                                        HStack {
                                            ForEach(0..<practice.correctWord.count, id: \.self) { index in
                                                let correctLetter = practice.correctWord[practice.correctWord.index(practice.correctWord.startIndex, offsetBy: index)]
                                                
                                                if index < practice.answerWord.count {
                                                    if practice.answerWord.indices.contains(practice.answerWord.index(practice.answerWord.startIndex, offsetBy: index)) {
                                                        
                                                        let textColor: Color = correctLetter == practice.answerWord[practice.answerWord.index(practice.answerWord.startIndex, offsetBy: index)] ? .green : .red
                                                        
                                                        if correctLetter != practice.answerWord[practice.answerWord.index(practice.answerWord.startIndex, offsetBy: index)] {
                                                            
                                                            //                                                        addSumWordFalse()
                                                        }
                                                        
                                                        Text(String(correctLetter))
                                                            .foregroundColor(textColor)
                                                    } else {
                                                        let textColor: Color = correctLetter == " " ? .green : .red
                                                        
                                                        if correctLetter != " " {
                                                            //                                                        addSumWordFalse()
                                                        }
                                                        
                                                        Text(String(correctLetter))
                                                            .foregroundColor(textColor)
                                                    }
                                                } else {
                                                    //                                                addSumWordFalse()
                                                    
                                                    Text(String(correctLetter))
                                                        .foregroundColor(.red)
                                                }
                                            }
                                            Spacer()
                                            
                                            //
                                            //                                Text("\(String(format: "%.0f", Double(sumWordFalse)/Double(practice.correctWord.count)*100))%")
                                            //                                    .font(.system(size: 20))
                                            //                                        Text("9%")
                                        }
                                        .padding(50)
                                        
                                    }
                                }
                                .onTapGesture {
                                    isShowingPopup.toggle()
                                    correctWord = practice.correctWord
                                    answerWord = practice.answerWord
                                    
                                    isTryAgain.toggle()
                                    getSpeechPrompt = practice.correctWord
                                    
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.trailing, 30)
                }
                .padding(.top, 20)
                Spacer()
            }
            .padding(.leading, 30)
            
            if isShowingPopup {
                PopUpView(correctWord: correctWord, answerWord: answerWord, isShowingPopup: $isShowingPopup, isRandomSpeechPrompt: $isRandomSpeechPrompt, counterWord: $counterWord, isTryAgain: $isTryAgain, getSpeechPrompt: $getSpeechPrompt)
            }
        }
        .onAppear {
            wordPracticeViewModel.getAllWordPractices(userID: userViewModel.userLogin!.userID)
            
            setProgressBarWord()
            
            totalSumWordArrays = wordArrays.flatMap { $0.values }.reduce(0, +)
            
            sumWordFalse = []
        }
    }
    
    func addSumWordFalse() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            sumWordFalse.append("true")
        }
    }
    
    func setProgressBarWord() {
        var words: String = ""
        wordArrays = []
        
        
        for wordPractice in wordPracticeViewModel.wordPractices {
            for index in 0..<wordPractice.correctWord.count {
                let correctLetter = wordPractice.correctWord[wordPractice.correctWord.index(wordPractice.correctWord.startIndex, offsetBy: index)]
                
                if index < wordPractice.answerWord.count {
                    if wordPractice.answerWord.indices.contains(wordPractice.answerWord.index(wordPractice.answerWord.startIndex, offsetBy: index)) {
                        
                        if correctLetter == wordPractice.answerWord[wordPractice.answerWord.index(wordPractice.answerWord.startIndex, offsetBy: index)] {
                            if words != "" {
                                let containsWord = wordArrays.contains { dict in
                                    dict.keys.contains(words)
                                }
                                
                                if containsWord {
                                    for (index, dict) in wordArrays.enumerated() {
                                        if dict[words] != nil {
                                            wordArrays[index][words] = wordArrays[index][words]! + 1
                                            break
                                        }
                                    }
                                } else {
                                    wordArrays.append([words: 1])
                                }
                                words = ""
                            }
                        } else {
                            words += String(correctLetter)
                            
                            if index == wordPractice.correctWord.count - 1 {
                                let containsWord = wordArrays.contains { dict in
                                    dict.keys.contains(words)
                                }
                                
                                if containsWord {
                                    for (index, dict) in wordArrays.enumerated() {
                                        if dict[words] != nil {
                                            wordArrays[index][words] = wordArrays[index][words]! + 1
                                            break
                                        }
                                    }
                                } else {
                                    wordArrays.append([words: 1])
                                }
                                words = ""
                            }
                        }
                        
                    } else {
                        
                        if correctLetter == " " {
                            if words != "" {
                                let containsWord = wordArrays.contains { dict in
                                    dict.keys.contains(words)
                                }
                                
                                if containsWord {
                                    for (index, dict) in wordArrays.enumerated() {
                                        if dict[words] != nil {
                                            wordArrays[index][words] = wordArrays[index][words]! + 1
                                            break
                                        }
                                    }
                                } else {
                                    wordArrays.append([words: 1])
                                }
                                words = ""
                            }
                        } else {
                            words += String(correctLetter)
                            
                            if index == wordPractice.correctWord.count - 1 {
                                let containsWord = wordArrays.contains { dict in
                                    dict.keys.contains(words)
                                }
                                
                                if containsWord {
                                    for (index, dict) in wordArrays.enumerated() {
                                        if dict[words] != nil {
                                            wordArrays[index][words] = wordArrays[index][words]! + 1
                                            break
                                        }
                                    }
                                } else {
                                    wordArrays.append([words: 1])
                                }
                                words = ""
                            }
                        }
                    }
                } else {
                    words += String(correctLetter)
                    
                    if index == wordPractice.correctWord.count - 1 {
                        let containsWord = wordArrays.contains { dict in
                            dict.keys.contains(words)
                        }
                        
                        if containsWord {
                            for (index, dict) in wordArrays.enumerated() {
                                if dict[words] != nil {
                                    wordArrays[index][words] = wordArrays[index][words]! + 1
                                    break
                                }
                            }
                        } else {
                            wordArrays.append([words: 1])
                        }
                        words = ""
                    }
                }
            }
        }
    }
}

#Preview {
    EvaluationWordIndependentView()
}
