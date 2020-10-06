//
//  EntryController.swift
//  Journal Cloudkit
//
//  Created by Alex Kennedy on 10/5/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    
    //MARK: - CRUD
    func createEntry(with title: String, body: String, completion: @escaping (Result<Entry?, EntryError>) -> Void) {
        
        let newEntry = Entry(title: title, body: body)
        saveEntry(entry: newEntry, completion: completion)
    }
    
    
    func saveEntry(entry: Entry, completion: @escaping (Result<Entry?, EntryError>) ->Void) {
        let entryRecord = CKRecord(entry: entry)
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.ckError(error)))
                return
            }
            
            guard let record = record,
                let savedEntry = Entry(ckRecord: record) else { return completion(.failure(.unwrapError))}
            
            print("Entry saved successfully")
            self.entries.insert(savedEntry, at: 0)
            completion(.success(savedEntry))
        }
    }
    
    
    func fetchEntriesWith(completion: @escaping (Result<[Entry]?, EntryError>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryStrings.recordTypeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                completion(.failure(.ckError(error)))
            }
            
            guard let records = records else { return completion(.failure(.unwrapError)) }
            print("Fetched Entries successfully")
            
            let fetchedEntries = records.compactMap({ Entry(ckRecord: $0) })
            completion(.success(fetchedEntries))
        }
    }
}




