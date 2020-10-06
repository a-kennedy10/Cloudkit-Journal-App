//
//  Entry.swift
//  Journal Cloudkit
//
//  Created by Alex Kennedy on 10/5/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation
import CloudKit

struct EntryStrings {
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timestampKey = "timestamp"
    static let recordTypeKey = "Entry"
}


class Entry {
    let title: String
    let body: String
    let timestamp: Date
    let ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
        }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryStrings.recordTypeKey, recordID: entry.ckRecordID)
        self.setValuesForKeys ([
            EntryStrings.bodyKey : entry.body,
            EntryStrings.titleKey : entry.title,
            EntryStrings.timestampKey : entry.timestamp
            
        ])
    }
}

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryStrings.titleKey] as? String,
            let body = ckRecord[EntryStrings.bodyKey] as? String,
            let timestamp = ckRecord[EntryStrings.timestampKey] as? Date
            else { return nil }
        
        self.init(title: title, body: body, timestamp: timestamp)
    }
}
