//
//  UserModel.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import Foundation
import SwiftData

enum UserType: String, Codable {
    case pasien
    case terapis
}

@Model
final class UserModel: Identifiable, CustomPersistentModel {
    @Attribute var slug: String = ""
    @Attribute var recordName: String = ""
    @Attribute var userID: String = ""
    @Attribute var firstName: String = ""
    @Attribute var lastName: String = ""
    @Attribute var email: String = ""
    @Attribute var userType: UserType = UserType.pasien
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    var WordPractice: [WordPracticeModel]?
    
    init(slug: String = "", recordName: String = "", userID: String, firstName: String, lastName: String, email: String, userType: UserType = UserType.pasien) {
        self.recordName = recordName
        self.slug = slug
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userType = userType
        createdAt = Date()
        updatedAt = Date()
    }
}
