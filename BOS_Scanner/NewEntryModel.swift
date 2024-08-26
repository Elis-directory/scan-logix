//
//  NewEntryModel.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 8/23/24.
//


import SwiftUI
import SwiftData

@Model
class NewEntryModel: Identifiable {
    var id: UUID
    var name: String
    var price: CGFloat
    var upc: String
    var category: String
    var imageData: Data?

    init(id: UUID, name: String, price: CGFloat, upc: String, category: String, imageData: Data? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.upc = upc
        self.category = category
        self.imageData = imageData
    }
}


