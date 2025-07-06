//
//  Item.swift
//  Daily Us
//
//  Created by Jeiwinfrey Ulep on 7/6/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
