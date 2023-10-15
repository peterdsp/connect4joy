//
//  Item.swift
//  connect4joy
//
//  Created by Petros Dhespollari on 15/10/23.
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
