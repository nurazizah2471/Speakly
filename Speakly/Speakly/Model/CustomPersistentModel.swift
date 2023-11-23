//
//  CustomPersistentModel.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import SwiftData

protocol CustomPersistentModel: PersistentModel {
    var slug: String { get set }
}
