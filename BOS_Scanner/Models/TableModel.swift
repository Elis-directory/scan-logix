//
//  TableModel.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 7/28/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class TableModel: Identifiable {
    var id: UUID
    var name: String
    var items: [ItemModel]
    
    init(id: UUID, name: String, items: [ItemModel]) {
        self.id = id
        self.name = name
        self.items = items
    }
}
