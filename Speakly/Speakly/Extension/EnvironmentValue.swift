//
//  EnvironmentValue.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import Foundation
import SwiftUI

// MARK: - Environment Values

extension EnvironmentValues {
    var userViewModel: UserViewModel {
        get { self[UserViewModelKey.self] }
        set { self[UserViewModelKey.self] = newValue }
    }
    
    var cloudKitManager: CloudKitManager {
        get { self[CloudKitManagerKey.self] }
        set { self[CloudKitManagerKey.self] = newValue }
    }
    
    var wordPracticeViewModel: WordPracticeViewModel {
        get { self[WordPracticeViewModelKey.self] }
        set { self[WordPracticeViewModelKey.self] = newValue }
    }
}

// MARK: - View Model Keys

private struct UserViewModelKey: EnvironmentKey {
    static var defaultValue: UserViewModel = .init()
}

private struct CloudKitManagerKey: EnvironmentKey {
    static var defaultValue: CloudKitManager = .init()
}

private struct WordPracticeViewModelKey: EnvironmentKey {
    static var defaultValue: WordPracticeViewModel = .init()
}
