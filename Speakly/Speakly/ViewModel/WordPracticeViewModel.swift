//
//  WordPractice.swift
//  Speakly
//
//  Created by Nur Azizah on 23/11/23.
//

import Foundation
import SwiftData

@Observable class WordPracticeViewModel: BaseViewModel {
    static var shared = WordPracticeViewModel()
    
    var wordPractices = [WordPracticeModel]()
    var getSpeechPrompt: String?
    
    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
    }
    
    func addWordPractice(wordPractice: WordPracticeModel) {
        print("iniiiii 0")
        if let getWordPractice = findWordPractice(wordPractice: wordPractice) {
            resetWordPractice(wordPractice: wordPractice, wordPracticeOld: getWordPractice)
            print("iniiiii 1")
        } else {
            wordPractice.user = UserViewModel.shared.userLogin!
            modelContext?.insert(wordPractice)
            try? modelContext?.save()
            
            CloudKitManager.shared.wordPracticeSaveToCloud(wordPractice) { error in
                if let error = error {
                    print("Error saving to CloudKit: \(error.localizedDescription)")
                } else {
                    print("Saved successfully")
                }
            }
            
            print("iniiiii 2")
        }
    }
    
    func resetWordPractice(wordPractice: WordPracticeModel, wordPracticeOld: WordPracticeModel) {
        wordPracticeOld.answerWord = wordPractice.answerWord
        try? modelContext?.save()
        
        CloudKitManager.shared.wordPracticeUpdateToCloud(wordPractice, wordPracticeOld) { error in
            if let error = error {
                print("Error updating to CloudKit: \(error.localizedDescription)")
            } else {
                print("Updated successfully")
            }
        }
    }
    
    func findWordPractice(wordPractice: WordPracticeModel) -> WordPracticeModel? {
        let userID = wordPractice.userID
        let getCrrectWord = wordPractice.correctWord
        
        let fetchDescriptor = FetchDescriptor<WordPracticeModel>(
            predicate: #Predicate {
                $0.userID == userID && $0.correctWord == getCrrectWord
            },
            sortBy: [SortDescriptor<WordPracticeModel>(\.createdAt)]
        )

        let getWordPractices = (try? modelContext?.fetch(fetchDescriptor).first ?? nil) ?? nil
        return getWordPractices
    }
    
    
    func getAllWordPractices(userID: String) {
        let fetchDescriptor = FetchDescriptor<WordPracticeModel>(
            predicate: #Predicate {
                $0.userID == userID
            },
            sortBy: [SortDescriptor<WordPracticeModel>(\.createdAt)]
        )

        wordPractices = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }
    
    func deleteAllUser(userID: String) {
        let fetchDescriptor = FetchDescriptor<WordPracticeModel>(
            predicate: #Predicate {
                $0.userID == userID
            },
            sortBy: [SortDescriptor<WordPracticeModel>(\.createdAt)]
        )

        wordPractices = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
        
        for wordPractice in wordPractices {
            modelContext?.delete(wordPractice)
            try? modelContext?.save()
        }
    }
}
