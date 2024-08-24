//
//  ItemModel.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 7/28/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class ItemModel: Identifiable {
    var id: UUID
    var name: String
    var currentPrice: CGFloat
    var pricesHistory: [CGFloat]
    var hyperlink: String
    
    init(id: UUID, name: String, currentPrice: CGFloat, pricesHistory: [CGFloat], hyperlink: String) {
        self.id = id
        self.name = name
        self.currentPrice = currentPrice
        self.pricesHistory = pricesHistory
        self.hyperlink = hyperlink
    }

}
