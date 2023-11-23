//
//  BaseViewModel.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import Foundation
import SwiftData

protocol BaseViewModelProtocol {
    var modelContext: ModelContext? { get set }
}

@Observable class BaseViewModel {
    var modelContext: ModelContext? = SpeaklyApp.modelContext
}
