//
//  PracticeWordIndependentView.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import SwiftUI
import SwiftSpeech
import Speech
import Combine

struct PracticeWordIndependentView: View {
    @Environment(\.wordPracticeViewModel) private var wordPracticeViewModel
    @Environment(\.userViewModel) private var userViewModel
    
    @State private var speechPrompt = "prompt"
    
    @State private var isStartButtonPulsing = false
    @State private var isSpeechButtonPulsing = false
    
    @State private var pointsInSession = 0
    
    @State private var cancellables: Set<AnyCancellable> = []
    @State private var counterWord: Int = 0
    @State private var isShowingPopup = false
    @State private var answerWord: String = ""
    @State private var isRandomSpeechPrompt: Bool = false
    @State var isTryAgain: Bool = false
    @State var getSpeechPrompt: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Latihan mandiri")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }.padding(.leading, 30)
                    .padding(.top, 25)
                
                GeometryReader { geometry in
                    ZStack(alignment: .top){
                        VStack {
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color.init(hex: "D3EFFF"))
                                        .frame(width: 271, height: 261)
                                    
                                    VStack(spacing: 10) {
                                        Text("\(counterWord)")
                                            .foregroundColor(Color.init(hex: "0C609D"))
                                            .bold()
                                            .font(.system(size: 64))
                                            .multilineTextAlignment(.center)
                                        
                                        Text("Latihan terselesaikan")
                                            .foregroundColor(Color.init(hex: "0C609D"))
                                            .font(.system(size: 16))
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                            .padding(.top, 30)
                            
                            VStack {
                                ZStack {
                                    VStack(alignment: .leading) {
                                        Text("Ucapkan kata berikut...")
                                            .bold()
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 20))
                                            .padding(.bottom, 5)
                                        
                                        Text(speechPrompt)
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.01)
                                            .bold()
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity)
                                            .padding(18)
                                            .background(Color(UIColor.systemGray6))
                                            .cornerRadius(40)
                                            .clipped()
                                            .padding(2)
                                            .background(.black)
                                            .cornerRadius(240)
                                            .clipped()
                                            .id("Prompt" + speechPrompt)
                                        
                                        Spacer()
                                    }
                                    .animation(.easeInOut(duration: 0.7), value: speechPrompt)
                                    .padding(.horizontal, 32)
                                    .padding(.top, Screen.height*0.1)
                                    
                                    VStack{
                                        SwiftSpeech.RecordButton()
                                            .swiftSpeechRecordOnHold(
                                                sessionConfiguration: SwiftSpeech.Session.Configuration(locale: Locale(identifier: "id-ID")),
                                                animation: .linear(duration: 0.3),
                                                distanceToCancel: 50
                                            )
                                            .onStopRecording { session in
                                                session.stopRecording() // Stop the recording session
                                                
                                                // Subscribe to the resultPublisher to receive recognition results
                                                session.resultPublisher?
                                                    .sink (
                                                        receiveCompletion: { completion in
                                                            // Handle completion if needed
                                                            switch completion {
                                                            case .finished:
                                                                break
                                                            case .failure(let error):
                                                                print("Recognition result error: \(error)")
                                                            }
                                                        },
                                                        receiveValue: { result in
                                                            if result.isFinal {
                                                                // Call your function when recognition is finalized
                                                                                                                            checkPronunciation(result.bestTranscription.formattedString)
                                                                
                                                                answerWord = result.bestTranscription.formattedString
                                                                
                                                                isShowingPopup.toggle()
                                                                                                                            }
                                                        }
                                                    )
                                                    .store(in: &cancellables) // Store the subscription
                                            }
                                            .pulsingBackgroundShape(
                                                color: Color.init(hex: "59B3E9"),
                                                shape: Circle(),
                                                isPulsing: $isSpeechButtonPulsing,
                                                maxXScale: 1.5,
                                                maxYScale: 1.5
                                            )
                                            .font(.system(size: 50, weight: .medium, design: .default))
                                            .padding(.bottom, geometry.size.height * 0.08)
                                    }
                                    .padding(.top, 150)
                                }
                                
                            }
                            .frame(height: geometry.size.height * 0.75)
                        }
                    }
                }
            }
            .onAppear {
                generateRandomPrompt()
                requestMicrophonePermission()
                requestSpeechRecognitonPermission()
                
                if let getSpeechPrompt = wordPracticeViewModel.getSpeechPrompt {
                    speechPrompt = getSpeechPrompt
                }
            }
            .onChange(of: isRandomSpeechPrompt) {_ in
                if isRandomSpeechPrompt {
                    generateRandomPrompt()
                    isRandomSpeechPrompt.toggle()
                }
            }
            
            if isShowingPopup {
                PopUpView(correctWord: speechPrompt.uppercased(), answerWord: answerWord.uppercased(), isShowingPopup: $isShowingPopup, isRandomSpeechPrompt: $isRandomSpeechPrompt, counterWord: $counterWord, isTryAgain: $isTryAgain, getSpeechPrompt: $getSpeechPrompt)
            }
        }
    }
    
    func requestMicrophonePermission() {
        let audioSession = AVAudioSession.sharedInstance()
        
        audioSession.requestRecordPermission { granted in
            if granted {
                print("Microphone permission granted.")
            } else {
                print("Microphone permission denied.")
            }
        }
    }
    
    func requestSpeechRecognitonPermission() {
        SFSpeechRecognizer.requestAuthorization { authorizationStatus in
            switch authorizationStatus {
            case .authorized:
                print("Speech recognition authorized.")
            case .denied:
                print("Speech recognition denied.")
            case .restricted:
                print("Speech recognition restricted.")
            case .notDetermined:
                print("Speech recognition not determined.")
            @unknown default:
                fatalError("Unknown authorization status.")
            }
        }
    }
    
    func checkPronunciation(_ recognisedSpeech: String) {
        wordPracticeViewModel.addWordPractice(wordPractice: WordPracticeModel(userID: userViewModel.userLogin!.userID, correctWord: speechPrompt.uppercased(), answerWord: recognisedSpeech.uppercased()))
    }
    
    func generateRandomPrompt() {
        speechPrompt = promptArray.randomElement()?.uppercased() ?? ""
    }
    
    func simpleHaptics(hapticType: String) {
        let generator = UINotificationFeedbackGenerator()
        if hapticType == "correct" {
            generator.notificationOccurred(.success)
        } else if hapticType == "incorrect" {
            generator.notificationOccurred(.error)
        }
    }
}


#Preview {
    PracticeWordIndependentView()
}
