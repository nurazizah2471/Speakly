//
//  UserViewModel.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import Foundation
import SwiftData

@Observable class UserViewModel: BaseViewModel {
    static var shared = UserViewModel()
    
    var userLogin: UserModel?
    
    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
    }
    
    func addUser(userData: UserModel) {
        modelContext?.insert(userData)
        try? modelContext?.save()
        
        CloudKitManager.shared.saveToCloud(userData) { error in
            if let error = error {
                print("Error saving to CloudKit: \(error.localizedDescription)")
            } else {
                print("Saved successfully")
            }
        }
    }
    
    func findUser(userID: String) -> [UserModel]? {
        let fetchDescriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate {
                $0.userID == userID
            },
            sortBy: [SortDescriptor<UserModel>(\.createdAt)]
        )

        let getUserDatas = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
        return getUserDatas
    }
    
    func deleteAllUser() {
        let fetchDescriptor = FetchDescriptor<UserModel>(
            sortBy: [SortDescriptor<UserModel>(\.createdAt)]
        )

        let getUserDatas = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
        
        for getUserData in getUserDatas {
            modelContext?.delete(getUserData)
            try? modelContext?.save()
        }
    }
    
    func getAllUser() -> [UserModel]? {
        let fetchDescriptor = FetchDescriptor<UserModel>(
            sortBy: [SortDescriptor<UserModel>(\.createdAt)]
        )

        let getUserDatas = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
        
        return getUserDatas
    }
    
    func setUserLogin(_ userID: String) {
        if let userData = findUser(userID: userID) {
            userLogin = userData.first
        }
        
        
    }
    
    func fetchUserData(userID: String, completion: @escaping (String) -> Void) {
        CloudKitManager.shared.fetchFromCloud(userID: userID) { (record, error) in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
            } else if let userRecord = record {
                // Access user data from the fetched record
                let userID = userRecord.userID
                let firstName = userRecord.firstName 
                let lastName = userRecord.lastName 
                let email = userRecord.email
                
                // Use the fetched data as needed
                print("User ID: \(userID), Name: \(firstName) \(lastName), Email: \(email)")
                completion(userID)
            } else {
                print("No user data found")
                completion("no")
            }
        }
    }
}
