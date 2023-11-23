//
//  WordPracticeModel.swift
//  Speakly
//
//  Created by Nur Azizah on 23/11/23.
//

import Foundation
import SwiftData

@Model
final class WordPracticeModel: Identifiable, CustomPersistentModel {
    @Attribute var slug: String = ""
    @Attribute var recordName: String = ""
    @Attribute var userID: String = ""
    @Attribute var correctWord: String = ""
    @Attribute var answerWord: String = ""
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    var user: UserModel?
    
    init(slug: String = "", recordName: String = "", userID: String, correctWord: String, answerWord: String) {
        self.recordName = recordName
        self.slug = slug
        self.userID = userID
        self.correctWord = correctWord
        self.answerWord = answerWord
        createdAt = Date()
        updatedAt = Date()
    }
}

