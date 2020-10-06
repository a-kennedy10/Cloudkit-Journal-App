//
//  EntryError.swift
//  Journal Cloudkit
//
//  Created by Alex Kennedy on 10/5/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case unwrapError
}
