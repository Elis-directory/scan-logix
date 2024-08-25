//
//  NewEntryModel.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/23/24.
//


import Foundation
import SwiftUI
import SwiftData

@Model
class NewEntryModel: Identifiable {
    var id: UUID
    var name: String
    var price: CGFloat
    var upc: String
    var category: String

    init(id: UUID, name: String, price: CGFloat, upc: String, category: String) {
        self.id = id
        self.name = name
        self.price = price
        self.upc = upc
        self.category = category
    }

}

