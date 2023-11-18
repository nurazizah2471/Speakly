//
//  ContentView.swift
//  Speakly
//
//  Created by Daniel Aprillio on 18/11/23.
//

import SwiftUI
import SwiftSpeech
import Speech
import Combine

struct ContentView: View {
    
    @State private var speechPrompt = "prompt"
    
    @State private var isStartButtonPulsing = false
    @State private var isSpeechButtonPulsing = false
    
    @State private var pointsInSession = 0
    
    @State private var cancellables: Set<AnyCancellable> = []
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .top){
                    VStack {
                    
                    VStack {
                        Spacer()
                        ZStack {
                            VStack(alignment: .leading) {
                                Text("Ucapkan kata berikut...")
                                    .bold()
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 18))
                                    .padding(.bottom, 5)
                                
                                Text(speechPrompt)
                                    .font(.system(size: 38))
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(5)
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
                            .padding(.top, 220)
                            
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
                                                    }
                                                }
                                            )
                                            .store(in: &cancellables) // Store the subscription
                                    }
                                    .pulsingBackgroundShape(
                                        color: .accentColor,
                                        shape: Circle(),
                                        isPulsing: $isSpeechButtonPulsing,
                                        maxXScale: 1.5,
                                        maxYScale: 1.5
                                    )
                                    .font(.system(size: 50, weight: .medium, design: .default))
                                    .padding(.bottom, geometry.size.height * 0.08)
                            }
                            .padding(.top, 242)
                        }
                            
                        }
                        .frame(height: geometry.size.height * 0.75)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(Color(UIColor.systemGray6))
        .onAppear {
            generateRandomPrompt()
            requestMicrophonePermission()
            requestSpeechRecognitonPermission()
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
        if recognisedSpeech.uppercased().contains(speechPrompt.uppercased()) {
            // Correct Pronunciation
            simpleHaptics(hapticType: "correct")
        } else {
            // Inorrect Pronunciation
            simpleHaptics(hapticType: "incorrect")
        }
        generateRandomPrompt()
    }
    
    func generateRandomPrompt() {
        speechPrompt = promptArray.randomElement()?.uppercased() ?? "PROMPT"
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
    ContentView()
}
