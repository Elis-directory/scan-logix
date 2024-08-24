//
//  dummyItem.swift
//  BOS_Scanner
//
//  Created by Eliran Chomoshe on 7/28/24.
//

import Foundation

struct DummyItemModel: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let currentPrice: CGFloat
    let pricesHistory: [CGFloat]
    let hyperlink: String

}



