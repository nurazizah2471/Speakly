//
//  SpeaklyApp.swift
//  Speakly
//
//  Created by Daniel Aprillio on 18/11/23.
//

import SwiftUI
import SwiftData

@main
struct SpeaklyApp: App {
    // MARK: - Bindables
    @Bindable private var routeViewModel = RouteViewModel.shared
    
    // MARK: - States

    @State private var userViewModel = UserViewModel.shared
    @State private var cloudKitManager = CloudKitManager.shared
    @State private var wordPracticeViewModel = WordPracticeViewModel.shared

    // MARK: - State Objects

//    @StateObject private var speechViewModel = SpeechRecognizerViewModel.shared
    
    private static let sharedModelContainer: ModelContainer = ModelGenerator.generator(false)
    static let modelContext = ModelContext(sharedModelContainer)
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $routeViewModel.navPath) {
                ContentViewContainer()
            }.environment(\.navigate, routeViewModel)
                .environment(\.font, Font.custom("CherryBomb-Regular", size: 24, relativeTo: .body))
                .environment(\.userViewModel, userViewModel)
                .environment(\.cloudKitManager, cloudKitManager)
                .environment(\.wordPracticeViewModel, wordPracticeViewModel)
//                .environmentObject(speechViewModel)
            
        }
    }
}
