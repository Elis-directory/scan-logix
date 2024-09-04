//  NewEntryModel.swift
//  BOS_Scanner
//
//  This file defines the NewEntryModel class, which models data entries for the Scanner application.
//  It represents entries stored in a SwiftData-based database, including details like name, price, UPC, and associated image data.
//
//  Created by EC


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


