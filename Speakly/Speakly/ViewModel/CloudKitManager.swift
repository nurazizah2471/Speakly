//
//  CloudKitManager.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import Foundation
import CloudKit

class CloudKitManager {
    static var shared = CloudKitManager()
    
    let container = CKContainer.default()
    let publicDatabase = CKContainer.default().publicCloudDatabase

    func saveToCloud(_ user: UserModel, completion: @escaping (Error?) -> Void) {
        // Convert SwiftData model to CKRecord
        let record = CKRecord(recordType: "UserModel")
        record.setValue(user.userID as CKRecordValue, forKey: "userID")
        record.setValue(user.firstName as CKRecordValue, forKey: "firstName")
        record.setValue(user.lastName as CKRecordValue, forKey: "lastName")
        record.setValue(user.email as CKRecordValue, forKey: "email")
        record.setValue(user.userType.rawValue as CKRecordValue, forKey: "userType")
        record.setValue(user.createdAt as CKRecordValue, forKey: "createdAt")
        record.setValue(user.updatedAt as CKRecordValue, forKey: "updatedAt")
        // Set other properties
        
        publicDatabase.save(record) { (_, error) in
            completion(error)
        }
    }
    
    func wordPracticeSaveToCloud(_ wordPractice: WordPracticeModel, completion: @escaping (Error?) -> Void) {
        // Convert SwiftData model to CKRecord
        let record = CKRecord(recordType: "WordPracticeModel")
        record.setValue(wordPractice.userID as CKRecordValue, forKey: "userID")
        record.setValue(wordPractice.answerWord as CKRecordValue, forKey: "answerWord")
        record.setValue(wordPractice.correctWord as CKRecordValue, forKey: "correctWord")
        record.setValue(wordPractice.createdAt as CKRecordValue, forKey: "createdAt")
        record.setValue(wordPractice.updatedAt as CKRecordValue, forKey: "updatedAt")
        // Set other properties
        
        publicDatabase.save(record) { (_, error) in
            completion(error)
        }
    }
    
    func wordPracticeUpdateToCloud(_ wordPractice: WordPracticeModel, _ wordPracticeOld: WordPracticeModel, completion: @escaping (Error?) -> Void) {
        let predicate = NSPredicate(format: "userID == %@ AND correctWord == %@", wordPracticeOld.userID, wordPracticeOld.correctWord)
        
        let query = CKQuery(recordType: "WordPracticeModel", predicate: predicate)
            
            // Fetch the existing record using the recordID
        publicDatabase.perform(query, inZoneWith: nil) { [self] (records, error) in
            if let error = error {
                completion(error)
                return
            }
            
            if let record = records?.first {
                // Update the properties of the retrieved record
                record.setValue(wordPractice.answerWord as CKRecordValue, forKey: "answerWord")
                record.setValue(wordPractice.updatedAt as CKRecordValue, forKey: "updatedAt")
                // Update other properties if needed
                
                // Save the updated record back to CloudKit
                publicDatabase.save(record) { (_, error) in
                    completion(error)
                }
            } else {
                let error = NSError(domain: "YourAppDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: "Record not found"])
                completion(error)
            }
        }
    }

    func fetchFromCloud(userID: String, completion: @escaping (UserModel?, Error?) -> Void) {
        let recordID = CKRecord.ID(recordName: userID)
        
        let predicate = NSPredicate(format: "userID == %@", userID)
        let query = CKQuery(recordType: "UserModel", predicate: predicate)
            
            publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
                print("dialah", userID)
                print("dialah", records?.first as Any)
                if let error = error {
                    completion(nil, error)
                } else if let record = records?.first {
                    let user = UserModel(userID: record["userID"] as! String, firstName: record["firstName"] as? String ?? "", lastName: record["lastName"] as? String ?? "", email: record["email"] as? String ?? "")
                    
                    completion(user, nil)
                } else {
                    completion(nil, nil)
                }
            }
        
        
//        publicDatabase.fetch(withRecordID: recordID) { (record, error) in
//            if let error = error {
//                completion(nil, error)
//            } else if let record = record {
//                // Convert CKRecord to SwiftData model
//                
//                let user = UserModel(userID: record.recordID.recordName, firstName: record["first_name"] as? String ?? "", lastName: record["last_name"] as? String ?? "", email: record["email"] as? String ?? "")
//                
//                completion(user, nil)
//            } else {
//                completion(nil, nil)
//            }
//        }
    }

    // Implement other CloudKit operations as needed
}
