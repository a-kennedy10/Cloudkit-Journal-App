//
//  DateExtension.swift
//  Journal Cloudkit
//
//  Created by Alex Kennedy on 10/5/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
